extends Node2D

@onready var ui: CanvasLayer = $UI
@onready var score_manager: Node = $Score_manager
@onready var problem: Node2D = $problem
const PROBLEM = preload("res://Scenes/problem.tscn")

func _ready() -> void:
	score_manager.score_updated.connect(_on_score_updated)
	score_manager.phase_finished.connect(_on_phase_finished)
	init_problem()

func _on_score_updated(score, max_score):
	var trust_gauge_value = 100 * score / max_score
	ui.update_trust_bar(trust_gauge_value, 0)
	print("score : " + str(score))
	
func _on_phase_finished():
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
	problem.queue_free()
	problem = PROBLEM.instantiate()

	(func():
		add_child(problem)
		init_problem()
	).call_deferred()

func _on_time_updated(time):
	print("time update")
	ui.update_timer_label(time)

func spawn_victims():
	print(problem.get_child(2))
	problem.rails.spawn_victims(randi_range(2, 10), "top")
	problem.rails.spawn_victims(randi_range(2, 10), "bot")

func free_victims():
	problem.rails.free_victims(problem.rails.loaded_victims)

func init_problem():
	spawn_victims()
	problem.choice_made.connect(_on_choice_made)
	problem.time_updated.connect(_on_time_updated)
