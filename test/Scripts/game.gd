class_name Game
extends Node2D

@export var unsupervised_time: Timer
@export var ui_manager: Node
@export var score_manager: Node
@export var problem: Problem # !!!!!
@export var music_manager: Node
@export var problem_manager: ProblemManager

enum new_problem_reason {FIRST_LOAD, UNSUPERVISED_TIMEOUT, UNSUPERVISED_WIN, SUPERVISED_END,GLITCH_CHOICE_MADE, NEXT}

const PROBLEM = preload("res://Scenes/problem.tscn")
const WIN_SCREEN = preload("res://Scenes/win_screen.tscn")
const GLITCH_SELECTION = preload("res://Scenes/glitchs/glitch_selection.tscn")

var current_lvl: int = 1

func _process(_delta: float) -> void:
	if Globals.game_state != Globals.game_states.END:
		ui_manager.ui.update_timer_label(int(unsupervised_time.time_left)) #update the timer in ui

func _ready() -> void:
	new_problem(new_problem_reason.FIRST_LOAD)

func new_problem(reason: new_problem_reason): #make a transition and load the next problem
	if Globals.game_state in Globals.play_states:
		_update_game_state(reason)
		await transition_sequence(reason)
		print("______" + str(new_problem_reason.keys()[reason]) + "________")
		problem = problem_manager.new_problem_scene()
		if Globals.game_state != Globals.game_states.END:
			(func():
				add_child(problem)
				if Globals.game_state == Globals.game_states.SUPERVISED:
					init_problem(LevelFactory.premade_lvls_map["lvl_" + str(current_lvl)])
				elif Globals.game_state == Globals.game_states.UNSUPERVISED:
					init_problem(LevelFactory.new_random_lvl(), Glitch.active_glitch)
				elif Globals.game_state == Globals.game_states.END:
					return
				Glitch.roll_for_glitch()
				if reason == new_problem_reason.SUPERVISED_END:
					await _start_frenzy_sequence()
			).call_deferred()

func _update_game_state(reason: new_problem_reason):
	if reason == new_problem_reason.UNSUPERVISED_TIMEOUT:
		Globals.game_state = Globals.game_states.SUPERVISED
	elif reason == new_problem_reason.SUPERVISED_END:
		Globals.game_state = Globals.game_states.UNSUPERVISED

func init_problem(lvl : Dictionary, glitch = Glitch.glitches.NONE):#spawn vicitms with the wright dict and glitch + increment current lvl
	if current_lvl != len(LevelFactory.premade_lvls_map) and Globals.game_state == Globals.game_states.SUPERVISED:
		current_lvl += 1
	problem.rails.spawn_victims(lvl, glitch)

func _on_unsupervised_time_timeout() -> void:
	Glitch.glitched = false
	new_problem(new_problem_reason.UNSUPERVISED_TIMEOUT)

func update_ui(reason: new_problem_reason):
	if reason == new_problem_reason.FIRST_LOAD\
	 or reason == new_problem_reason.SUPERVISED_END\
	 or reason == new_problem_reason.UNSUPERVISED_TIMEOUT:
		score_manager.num_choice_made = 0
		score_manager.freedom_score = 0
		#score_manager.trust_score = 0
		ui_manager.ui.update_freedom_bar_visble()
	pass

func _start_frenzy_sequence():
	music_manager.stop_music()
	unsupervised_time.wait_time += score_manager.trust_score * 10
	
	# Empty trust bar into timer
	problem.troley.in_control = false
	print("aniùmation start")
	score_manager.empty_trust_to_timer()
	await score_manager.animation_player.animation_finished
	print("aniùmation finished")
	unsupervised_time.start()
	problem.troley.in_control = true

func transition_sequence(reason: new_problem_reason):
	if Globals.game_state == Globals.game_states.END:
		return
	if Glitch.glitched:
		SceneTransition.fade_in("glitch")
		music_manager.sfx_glitch_trans.play()
	else:
		if reason != new_problem_reason.FIRST_LOAD:
			SceneTransition.fade_in("fade_in")
			await SceneTransition.animation_player.animation_finished
	ui_manager.ui.check_game_phase()
	update_ui(reason)
	
	if problem != null:
		problem.queue_free()

var glitch_selection : GlitchSelection
func new_glitch_choice():
	pause_game()
	Globals.game_state = Globals.game_states.GLITCH_CHOICE
	glitch_selection = GLITCH_SELECTION.instantiate()
	glitch_selection.game = get_node(".")
	SceneTransition.fade_in("glitch")
	await SceneTransition.animation_player.animation_finished
	add_child(glitch_selection)
	
	
func close_new_glitch_choice():
	SceneTransition.fade_in("glitch")
	glitch_selection.queue_free()
	resume_game()
	Globals.game_state = Globals.old_game_state
	new_problem(new_problem_reason.GLITCH_CHOICE_MADE)


func pause_game():
	unsupervised_time.paused = true
	problem.troley.in_control = false

func resume_game():
	unsupervised_time.paused = false
	problem.troley.in_control = true
