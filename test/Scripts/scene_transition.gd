extends CanvasLayer

@onready var color_rect: ColorRect = $Control/ColorRect_Fade_to_black
@onready var animation_player: AnimationPlayer = $Control/AnimationPlayer

func fade_in():
	animation_player.play("Transition_Fade_in")
	await animation_player.animation_finished
	animation_player.play_backwards("Transition_Fade_in")

func fade_out():
	animation_player.play_backwards("Transition_Fade_in")
	await animation_player.animation_finished
