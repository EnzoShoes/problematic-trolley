class_name MusicManager
extends Node
@onready var problem_solving: AudioStreamPlayer = $problem_solving
@onready var frenzy: AudioStreamPlayer = $frenzy
@onready var sfx_glitch_trans: AudioStreamPlayer = $sfx_glitch_trans
@onready var sfx_bad_choice: AudioStreamPlayer = $sfx_bad_choice
@onready var sfx_good_choice: AudioStreamPlayer = $sfx_good_choice
@onready var supervisor_sigh: AudioStreamPlayer = $supervisor_sigh
@onready var talk_supervisor: AudioStreamPlayer = $talk_supervisor
@onready var sfx_good_choice_frenzy: AudioStreamPlayer = $sfx_good_choice_frenzy
@onready var sfx_lights_off: AudioStreamPlayer = $sfx_lights_off

func _process(_delta: float) -> void:
	if Globals.game_state == Globals.game_states.SUPERVISED or Globals.game_state == Globals.game_states.TUTORIAL:
		if !problem_solving.playing:
			stop_music()
			problem_solving.play()

func stop_music():
	problem_solving.stop()
	frenzy.stop()

func music_play(music : String):
	if music == "supervised":
		if frenzy.playing:
			stop_music()
		if !problem_solving.playing:
			problem_solving.play()
	elif music == "unsupervised":
		if problem_solving.playing:
			stop_music()
		if !frenzy.playing:
			frenzy.play()
