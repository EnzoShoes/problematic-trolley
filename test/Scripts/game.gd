class_name Game
extends Node2D

@export var unsupervised_time: Timer
@export var ui_manager: Ui
@export var score_manager: ScoreManager
@export var problem: Problem # !!!!!
@export var music_manager: MusicManager
@export var problem_manager: ProblemManager
@export var tutorial_sequence : TutorialSequence

enum new_problem_reason {FIRST_LOAD, UNSUPERVISED_TIMEOUT, UNSUPERVISED_WIN, SUPERVISED_END,GLITCH_CHOICE_MADE, NEXT}

const PROBLEM = preload("res://Scenes/problem.tscn")
const WIN_SCREEN = preload("res://Scenes/win_screen.tscn")
const GLITCH_SELECTION = preload("res://Scenes/glitchs/glitch_selection.tscn")

var current_lvl: int = 1
var can_trolley_move: bool 
var max_ppl_on_rails: int: 
	get():
		max_ppl_on_rails = 8 * ( score_manager.freedom_score / score_manager.free_score_to_win) +1
		return 8 * ( score_manager.freedom_score / score_manager.free_score_to_win) +1


func _process(_delta: float) -> void:
	if Globals.game_state != Globals.game_states.END:
		ui_manager.ui.update_timer_label(int(unsupervised_time.time_left)) #update the timer in ui
	
	if problem.troley != null:
		if can_trolley_move:
			problem.troley.in_control = true
		else:
			problem.troley.in_control = false
	
func _ready() -> void:
	new_tutorial_problem(new_problem_reason.FIRST_LOAD)

func new_tutorial_problem(reason: new_problem_reason):
	print("______" + str(new_problem_reason.keys()[reason]) + "________")
	_update_game_state(reason)
	await transition_sequence(reason)
	problem = problem_manager.new_problem_scene()
	if reason == new_problem_reason.FIRST_LOAD:
		tutorial_sequence.run_intro_dialogue()
	if reason == new_problem_reason.NEXT:
		tutorial_sequence.run_tutorial_dialog()
	(func():
		add_child(problem)
		init_problem(LevelFactory.tutorial_lvls_map["lvl_" + str(tutorial_sequence.tutorial_lvl)])
	).call_deferred()

func new_play_problem(reason: new_problem_reason):
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
				init_problem(LevelFactory.new_random_lvl(max_ppl_on_rails), Glitch.active_glitch)
			elif Globals.game_state == Globals.game_states.END:
				return
			Glitch.roll_for_glitch()
			if reason == new_problem_reason.SUPERVISED_END:
				await _start_frenzy_sequence()
		).call_deferred()
	
func new_problem(reason: new_problem_reason): #make a transition and load the next problem
	print("coucou new prob")
	if Globals.game_state in Globals.play_states:
		new_play_problem(reason)
	elif Globals.game_state == Globals.game_states.TUTORIAL:
		new_tutorial_problem(reason)


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
	if !SceneTransition.animation_player.is_playing():
		Glitch.glitched = false
		new_problem(new_problem_reason.UNSUPERVISED_TIMEOUT)
	else: 
		await !SceneTransition.animation_player.animation_finished
		Glitch.glitched = false
		new_problem(new_problem_reason.UNSUPERVISED_TIMEOUT)

func update_ui(reason: new_problem_reason):
	ui_manager.ui.input_nudge.visible = false
	if reason == new_problem_reason.FIRST_LOAD\
	 or reason == new_problem_reason.SUPERVISED_END\
	 or reason == new_problem_reason.UNSUPERVISED_TIMEOUT:
		score_manager.num_choice_made = 0
		score_manager.freedom_score = 0
		#score_manager.trust_score = 0
		ui_manager.ui.update_freedom_bar_visble()

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
	music_manager.sfx_glitch_trans.play()
	SceneTransition.fade_in("glitch")
	Glitch.glitched = true
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
