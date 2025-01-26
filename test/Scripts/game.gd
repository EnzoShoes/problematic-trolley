extends Node2D

@onready var unsupervised_time: Timer = $unsupervised_time
@onready var ui_manager: Node = $ui_manager
@onready var score_manager: Node = $Score_manager
@onready var problem: Node2D = $problem
@onready var music_manager: Node = $music_manager

const PROBLEM = preload("res://Scenes/problem.tscn")
const WIN_SCREEN = preload("res://Scenes/win_screen.tscn")

var current_lvl: int = 1
var reset_ui : bool
var first_load = true
var new_phase : bool = false
var can_troley_move : bool = true

func _process(_delta: float) -> void:
	if Globals.game_state != Globals.game_states.END:
		ui_manager.ui.update_timer_label(int(unsupervised_time.time_left)) #update the timer in ui
	if problem.troley != null:
		if can_troley_move == false:
			problem.troley.in_control = false
		elif can_troley_move == true:
			problem.troley.in_control = true

func _ready() -> void:
	score_manager.phase_finished.connect(_on_phase_finished)
	new_problem()
	first_load = false
	
func new_problem(): #make a transition and load the next problem
	print("______________")
	if Globals.game_state == Globals.game_states.END:
		return
	if Glitch.glitched:
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
				return
			Glitch.roll_for_glitch()
			new_phase_sequence()
		).call_deferred()

func init_problem(lvl : Dictionary, glitch = Glitch.glitches.NONE):#spawn vicitms with the wright dict and glitch + increment current lvl
	if current_lvl != len(LevelFactory.premade_lvls_map) and Globals.game_state == Globals.game_states.SUPERVISED:
		current_lvl += 1
	problem.rails.spawn_victims(lvl, glitch)
	problem.choice_made.connect(_on_choice_made)

func _on_unsupervised_time_timeout() -> void:
	Glitch.glitched = false
	score_manager.phase_finished.emit()
	new_problem()

func _on_phase_finished():
	if Globals.game_state == Globals.game_states.SUPERVISED: 
		Globals.game_state = Globals.game_states.UNSUPERVISED
		new_phase = true
	elif Globals.game_state == Globals.game_states.UNSUPERVISED:
		Globals.game_state = Globals.game_states.SUPERVISED
		reset_ui = true

func _on_choice_made(choice: String):
	if choice == "good":
		score_manager.add_score(1)
		if Globals.game_state == Globals.game_states.UNSUPERVISED:
			if !music_manager.frenzy.playing:
				music_manager.music_play("unsupervised")
		music_manager.sfx_good_choice.play()
		ui_manager.background.flash("Good_Choice")
		await ui_manager.background.animation_finished
	elif choice == "bad":
		ui_manager.background.flash("Bad_Choice")
		music_manager.sfx_bad_choice.play()
		await ui_manager.background.animation_finished
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

func new_phase_sequence():
	if new_phase:
		music_manager.stop_music()
		unsupervised_time.wait_time += score_manager.trust_score * 10
		can_troley_move = false
		print("aniùmation start")
		score_manager.empty_trust_to_timer()
		await score_manager.animation_player.animation_finished
		print("aniùmation finished")
		unsupervised_time.start()
		can_troley_move = true
		new_phase = false
