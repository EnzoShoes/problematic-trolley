extends Node
@onready var problem_solving: AudioStreamPlayer = $problem_solving
@onready var frenzy: AudioStreamPlayer = $frenzy

func _process(_delta: float) -> void:
	if Globals.game_state == Globals.game_states.SUPERVISED:
		if !problem_solving.playing:
			stop_music()
			problem_solving.play()
	elif Globals.game_state == Globals.game_states.UNSUPERVISED:
		if !frenzy.playing:
			stop_music()
			frenzy.play()

func stop_music():
	problem_solving.stop()
	frenzy.stop()
