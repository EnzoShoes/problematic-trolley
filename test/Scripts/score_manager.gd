class_name ScoreManager
extends Node

signal trust_score_updated
signal freedom_score_updated
signal game_win

@export var choices_to_make: int = 5
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var game: Game
@export var tutorial_sequence: TutorialSequence

var free_score_to_win: int = 25

var best_free_score: int = 0

var freedom_score: int = 0:
	set(value):
		print("freedom = " + str(value) + " /"+ str(free_score_to_win))
		freedom_score = value
		freedom_score_updated.emit(value, free_score_to_win)
		check_for_win()
		if freedom_score > best_free_score:
			best_free_score = freedom_score

@export var trust_score:float = 0:
	set(value):
		trust_score = value
		trust_score_updated.emit(value, choices_to_make)

var num_choice_made: int = 0:
	set(value):
		print("num choices made = " +str(value))
		num_choice_made = value

func prepare_next_problem():
	if Globals.game_state == Globals.game_states.SUPERVISED and num_choice_made >= choices_to_make:
		game.new_problem(game.new_problem_reason.SUPERVISED_END)
		return
	game.new_problem(game.new_problem_reason.NEXT)

func add_score(points): #adds a point to the right score depending on the phase you are in, you only need to indicate when the player wins and the type of phase and it handles the rest
	if Globals.game_state == Globals.game_states.SUPERVISED:
		trust_score += points
		print("trust increased")
	elif Globals.game_state == Globals.game_states.UNSUPERVISED:
		freedom_score += points
		print("freedom increased") 
	else:
		printerr("no conditions met")
	
func check_for_win():
	if freedom_score >= free_score_to_win:
		game_win.emit()
		
@export var timer_val: float = 0:
	set(value):
		if game:
			game.ui_manager.ui.update_timer_label(value)
		timer_val = value

func empty_trust_to_timer():
	trust_score = 3
	timer_val = game.unsupervised_time.wait_time
	print("timer_val: " + str(timer_val))
	
	var anim = animation_player.get_animation("empty_trust_to_timer")
	
	var key_id = anim.track_find_key(0, 0.0)
	var timer_key_id = anim.track_find_key(0, 1.5)
	print("timer_key_id " + str(timer_key_id))
	
	anim.track_set_key_value(0, key_id, trust_score)
	anim.track_set_key_value(1, timer_key_id, timer_val)
	
	animation_player.play("empty_trust_to_timer")
	
	await animation_player.animation_finished
	game.ui_manager.ui.trust_gauge.visible = false

func check_for_new_glitch_choice(value: int, choice_map: Array, not_aquiered: Array):
	if value in choice_map and len(not_aquiered) != 0:
		choice_map.erase(value)
		await game.new_glitch_choice()
