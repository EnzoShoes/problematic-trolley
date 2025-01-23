extends Node2D

@onready var ui: CanvasLayer = $UI
@onready var score_manager: Node = $Score_manager
@onready var problem: Node2D = $problem

func _ready() -> void:
	score_manager.score_updated.connect(_on_score_updated)
	score_manager.phase_finished.connect(_on_phase_finished)
	problem.choice_made.connect(_on_choice_made)
	problem.time_updated.connect(_on_time_updated)
	
	spawn_victims()

func _on_score_updated(score, max_score):
	var trust_gauge_value = 100 * score / max_score
	ui.update_trust_bar(trust_gauge_value, 0)
	print("score : " + str(score))
	
func _on_phase_finished():
	print("on game finished entered")
	ui.end_game(score_manager.trust_score, score_manager.choices_to_make)
	problem.troley.in_control = false

func _on_choice_made(choice: String):
	if choice == "good":
		score_manager.add_score(1)
	elif choice == "bad":
		pass
	else:
		printerr("this type of choice is invalid")
		return
	score_manager.num_choice_made += 1
	problem.time_to_solve.start()
	free_victims()
	spawn_victims()

func _on_time_updated(time):
	ui.update_timer_label(time)

func spawn_victims():
	problem.spawn_victims(randi_range(2, 10), "top")
	problem.spawn_victims(randi_range(2, 10), "bot")

func free_victims():
	problem.free_victims(problem.loaded_victims)
