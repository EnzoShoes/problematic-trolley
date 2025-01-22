extends Node2D
@onready var time_to_solve: Timer = $time_to_solve
@onready var score_manager: Node = $Score_manager
@onready var ui_manager: Control = $UI/Control
@onready var troley_controls: Node2D = $troley_controls

var loaded_victims = {
	"top": [],
	"bot": []
}
var num_choice_made: int = 0
var choices_to_make: int = 5

func _ready() -> void:
	load_next_choice()

func _process(delta: float) -> void:
	update_time_ui(int(time_to_solve.time_left))
	check_for_end()
func calculate_winner() -> String:
	var top_score = 0
	var bot_score = 0
	
	for victim in loaded_victims["top"]:
		top_score += victim.value
		
	for victim in loaded_victims["bot"]:
		bot_score += victim.value
		
	return "top" if top_score > bot_score else "bot"

func spawn_victims(vic_num: int,vic_side: String) -> void:
	for i in range(vic_num):
			var new_victim = VictimFactory.new_victim(randi_range(0, len(Globals.victim_types) - 1))
			var current_spawn_point = get_node("spawn_points/spawn_" + vic_side + "/spawn_" + vic_side + "_" + str(i+1))
			current_spawn_point.add_child(new_victim)
			loaded_victims[vic_side].append(new_victim)

func free_victims(victims: Dictionary):
	for i in victims["top"]:
		i.queue_free()
	for i in victims["bot"]:
		i.queue_free()
	victims["top"].clear()
	victims["bot"].clear()

func load_next_choice():
	var animation_player = SceneTransition.get_node("Control/ColorRect/AnimationPlayer")
	SceneTransition.fade_in()
	await animation_player.animation_finished
	free_victims(loaded_victims)
	spawn_victims(randi_range(2, 10), "top")
	spawn_victims(randi_range(2, 10), "bot")
	num_choice_made += 1
	SceneTransition.fade_out()
	
	await animation_player.animation_finished
	time_to_solve.start()	

func bad_choice():
	load_next_choice()
	pass

func good_choice():
	load_next_choice()
	score_manager.add_score(1)
	pass

func _on_time_to_solve_timeout() -> void:
	bad_choice()

func _on_top_choice_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		if calculate_winner() == "bot":
			good_choice()
		else:
			bad_choice()

func _on_bot_choice_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		if calculate_winner() == "top":
			good_choice()
		else:
			bad_choice()

func update_time_ui(time_left):
	ui_manager.update_timer_label(time_left)

func check_for_end():
	if num_choice_made == choices_to_make:
		troley_controls.in_control = false
		score_manager.game_end() #sending info to score manager so it can send score to ui manager
		print("game ends")
