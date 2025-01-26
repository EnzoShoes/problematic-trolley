extends Node2D

@onready var unsupervised_time: Timer = $unsupervised_time
@onready var ui_manager: Node = $ui_manager
@onready var score_manager: Node = $Score_manager
@onready var problem: Node2D = $problem
@onready var music_manager: Node = $music_manager

const PROBLEM = preload("res://Scenes/problem.tscn")
const WIN_SCREEN = preload("res://Scenes/win_screen.tscn")

var current_lvl: int = 1
@export var glitch_proba: int = 70
var reset_ui : bool
var first_load = true

func _process(_delta: float) -> void:
	if Globals.game_state != Globals.game_states.END:
		update_timer_ui()

func _ready() -> void:
	score_manager.trust_score_updated.connect(_on_trust_score_updated)
	score_manager.freedom_score_updated.connect(_on_freedom_score_updated)
	score_manager.phase_finished.connect(_on_phase_finished)
	new_problem()
	first_load = false
	
func new_problem():
	if Globals.game_state == Globals.game_states.END:
		return
	print("______________")
	if glitched:
		SceneTransition.fade_in("glitch")
		music_manager.sfx_glitch_trans.play()
	else:
		if !first_load:
			SceneTransition.fade_in("fade_in")
			await SceneTransition.animation_player.animation_finished
	ui_manager.ui.check_game_phase()
	update_ui()
	if problem != null:
		problem.queue_free()
	problem = PROBLEM.instantiate()
	if Globals.game_state != Globals.game_states.END:
		(func():
			add_child(problem)
			if Globals.game_state == Globals.game_states.SUPERVISED:
				init_problem(LevelFactory.premade_lvls_map["lvl_" + str(current_lvl)])
			elif Globals.game_state == Globals.game_states.UNSUPERVISED:
				init_problem(LevelFactory.new_random_lvl(), Glitch.active_glitch)
			elif Globals.game_state == Globals.game_states.END:
				pass
			roll_for_glitch()
		).call_deferred()

func init_problem(lvl : Dictionary, glitch = Glitch.glitches.NONE):
	if current_lvl != len(LevelFactory.premade_lvls_map) and Globals.game_state == Globals.game_states.SUPERVISED:
		current_lvl += 1
	spawn_victims(lvl, glitch)
	problem.choice_made.connect(_on_choice_made)

func spawn_victims(lvl, glitch = Glitch.glitches.NONE):
	problem.rails.spawn_victims(lvl, glitch)

var glitched: bool
func roll_for_glitch():
	if Globals.game_state == Globals.game_states.UNSUPERVISED:
		var proba: int = randi_range(0, 100) 
		if proba > glitch_proba:
			glitched = false
		else:
			glitched = true
		if glitched == true:
			print("next lvl should be glitched")
			Glitch.active_glitch = randi_range(0,len(Glitch.glitches)-2)+1 #-1 +1 pour ne pas tomber sur NONE

func free_victims():
	problem.rails.free_victims(problem.rails.loaded_victims)

func activate_timer():
	unsupervised_time.start()

func update_timer_ui():
	ui_manager.ui.update_timer_label(int(unsupervised_time.time_left))

func _on_unsupervised_time_timeout() -> void:
	glitched = false
	score_manager.phase_finished.emit()
	new_problem()
	pass # Replace with function body.

func _on_trust_score_updated(score, max_score):
	var trust_gauge_value: float
	trust_gauge_value = 100 * score / max_score
	ui_manager.ui.update_trust_bar(trust_gauge_value)

func _on_freedom_score_updated(score, max_score):
	var freedom_gauge_value: float
	freedom_gauge_value = 100 * score / max_score
	ui_manager.ui.update_freedom_bar(freedom_gauge_value)

func _on_phase_finished():
	if Globals.game_state == Globals.game_states.SUPERVISED:
		score_manager.empty_trust_to_timer()
		Globals.game_state = Globals.game_states.UNSUPERVISED
		music_manager.stop_music()
		await score_manager.animation_player.animation_finished
		activate_timer()
	elif Globals.game_state == Globals.game_states.UNSUPERVISED:
		Globals.game_state = Globals.game_states.SUPERVISED
		reset_ui = true
	print("you are now in phase " + str(Globals.game_state))

func _on_choice_made(choice: String):
	if choice == "good":
		score_manager.add_score(1)
		if Globals.game_state == Globals.game_states.UNSUPERVISED:
			if !music_manager.frenzy.playing:
				music_manager.music_play("unsupervised")
		ui_manager.background.flash("Good_Choice")
		music_manager.sfx_good_choice.play()
		await ui_manager.background.animation_finished
		
	elif choice == "bad":
		ui_manager.background.flash("Bad_Choice")
		music_manager.sfx_bad_choice.play()
		await ui_manager.background.animation_finished
		pass
	else:
		printerr("this type of choice is invalid")
		return
	if Globals.game_state == Globals.game_states.SUPERVISED:
		score_manager.num_choice_made += 1
	new_problem()

func update_ui():
	if reset_ui:
		score_manager.num_choice_made = 0
		score_manager.freedom_score = 0
		score_manager.trust_score = 0
		reset_ui = false
	ui_manager.ui.update_freedom_bar_visble()
	pass
