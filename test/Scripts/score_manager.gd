extends Node

signal trust_score_updated
signal freedom_score_updated
signal phase_finished
signal game_win

@export var choices_to_make: int = 2
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var free_score_to_win: int = 2

var freedom_score: int = 0:
	set(value):
		print("freedom = " + str(value) + " /"+ str(free_score_to_win))
		freedom_score = value
		freedom_score_updated.emit(value, free_score_to_win)
		check_for_win()

@export var trust_score:float = 0:
	set(value):
		trust_score = value
		trust_score_updated.emit(value, choices_to_make)

var num_choice_made: int = 0:
	set(value):
		print("num choices made = " +str(value))
		num_choice_made = value
		if value >= choices_to_make:
			print("choices made is bigger")
			phase_finished.emit()

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
	else:
		pass

func empty_trust_to_timer():
	var anim = animation_player.get_animation("empty_trust_to_timer")
	var key_id = anim.track_find_key(0, 0.0)
	anim.track_set_key_value(0, key_id, trust_score)
	animation_player.play("empty_trust_to_timer")
	await animation_player.animation_finished
	pass
