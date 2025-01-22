extends CanvasLayer
@onready var color_rect: ColorRect = $Control/ColorRect
@onready var animation_player: AnimationPlayer = $Control/ColorRect/AnimationPlayer

func fade_in():
	animation_player.play("Transition")
	await animation_player.animation_finished
	animation_player.play_backwards("Transition")

func fade_out():
	animation_player.play_backwards("Transition")
	await animation_player.animation_finished
