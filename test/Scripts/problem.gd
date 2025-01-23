extends Node2D

signal time_updated
signal choice_made

@onready var time_to_solve: Timer = $time_to_solve
@onready var troley: Node2D = $troley



var loaded_victims = {
	"top": [],
	"bot": []
}

func _ready() -> void:
	load_next_choice()

func _process(delta: float) -> void:
	update_time_ui(int(time_to_solve.time_left))

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
			var current_spawn_point = get_node("rails/spawn_points/spawn_" + vic_side + "/spawn_" + vic_side + "_" + str(i+1))
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
	time_to_solve.start()

func bad_choice():
	print(" bad choice ;/")
	choice_made.emit("bad")

func good_choice():
	print(" good choice ;D")
	choice_made.emit("good")

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
	time_updated.emit(time_left)
