extends Node2D
@onready var time_to_solve: Timer = $time_to_solve
@onready var score_manager: Node = $Score_manager
@onready var ui_manager: Control = $UI/Control


var loaded_victims = {
	"top": [],
	"bot": []
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_next_choice()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_time_ui(int(time_to_solve.time_left))

	#if Input.is_action_just_pressed("ui_accept"):
		#spawn_victims(randi_range(2, 10), "top")
		#spawn_victims(randi_range(2, 10), "bot")
	#if Input.is_action_just_pressed("ui_cancel"):
		#free_victims(loaded_victims)
	
	print(str(calculate_winner()))
		
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
	free_victims(loaded_victims)
	spawn_victims(randi_range(2, 10), "top")
	spawn_victims(randi_range(2, 10), "bot")
	time_to_solve.start()
	pass

func bad_choice():
	load_next_choice()
	pass

func good_choice():
	load_next_choice()
	
	pass

func _on_time_to_solve_timeout() -> void:
	bad_choice()

func _on_good_choice_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		score_manager.add_score(1)
		good_choice()

func _on_bad_choice_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		bad_choice()

func update_time_ui(time_left):
	ui_manager.update_timer_label(time_left)
