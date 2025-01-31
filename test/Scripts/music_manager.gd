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
@onready var tutorial_music: AudioStreamPlayer = $tutorial_music
@onready var sfx_notification: AudioStreamPlayer = $sfx_notification

func _process(_delta: float) -> void:
	if Globals.game_state == Globals.game_states.SUPERVISED:
		if !problem_solving.playing:
			stop_music()
			problem_solving.play()

func stop_music():
	problem_solving.stop()
	frenzy.stop()
	tutorial_music.stop()
	
func music_play(music : String):
	if music == "supervised":
		if frenzy.playing or tutorial_music.playing:
			stop_music()
		if !problem_solving.playing:
			problem_solving.play()
	elif music == "unsupervised":
		if problem_solving.playing:
			stop_music()
		if !frenzy.playing:
			frenzy.play()
	elif music == "tutorial":
		if frenzy.playing:
			stop_music()
		if !tutorial_music.playing:
			tutorial_music.play()


func _on_tutorial_music_finished() -> void:
	music_play("tutorial")
	pass # Replace with function body.


func _on_problem_solving_finished() -> void:
	music_play("supervised")
	pass # Replace with function body.


func _on_frenzy_finished() -> void:
	music_play("unsupervised")
	pass # Replace with function body.
