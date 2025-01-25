extends Node2D

@onready var unsupervised_time: Timer = $unsupervised_time
@onready var ui: CanvasLayer = $UI
@onready var score_manager: Node = $Score_manager
@onready var problem: Node2D = $problem
const PROBLEM = preload("res://Scenes/problem.tscn")
var current_lvl: int = 1

func _process(_delta: float) -> void:
	update_timer_ui()

func _ready() -> void:
	score_manager.score_updated.connect(_on_score_updated)
	score_manager.phase_finished.connect(_on_phase_finished)
	init_problem(VictimFactory.premade_lvls_map["lvl_" + str(current_lvl)])

func _on_score_updated(score, max_score):
	var trust_gauge_value = 100 * score / max_score
	ui.update_trust_bar(trust_gauge_value, 0)
	print("score : " + str(score))
	
func _on_phase_finished():
	if Globals.game_state == Globals.game_states.SUPERVISED:
		Globals.game_state = Globals.game_states.UNSUPERVISED
		activate_timer()
	elif Globals.game_state == Globals.game_states.UNSUPERVISED:
		Globals.game_state = Globals.game_states.SUPERVISED

func _on_choice_made(choice: String):
	if choice == "good":
		score_manager.add_score(1)
	elif choice == "bad":
		pass
	else:
		printerr("this type of choice is invalid")
		return
	score_manager.num_choice_made += 1
	new_problem()

func spawn_victims(lvl):
	print(problem.get_child(2))
	problem.rails.spawn_victims(lvl)

func free_victims():
	problem.rails.free_victims(problem.rails.loaded_victims)

func init_problem(lvl):
	if current_lvl != len(VictimFactory.premade_lvls_map) and Globals.game_state == Globals.game_states.SUPERVISED:
		current_lvl += 1
	spawn_victims(lvl)
	problem.choice_made.connect(_on_choice_made)

func activate_timer():
	unsupervised_time.start()

func _on_unsupervised_time_timeout() -> void:
	score_manager.phase_finished.emit()
	new_problem()
	pass # Replace with function body.

func new_problem():
	problem.queue_free()
	problem = PROBLEM.instantiate()

	(func():
		add_child(problem)
		if Globals.game_state == Globals.game_states.SUPERVISED:
			init_problem(VictimFactory.premade_lvls_map["lvl_" + str(current_lvl)])
		elif Globals.game_state == Globals.game_states.UNSUPERVISED:
			init_problem(VictimFactory.new_random_lvl())
		elif Globals.game_state == Globals.game_states.END:
			pass
	).call_deferred()

func update_timer_ui():
	ui.update_timer_label(int(unsupervised_time.time_left))
	
