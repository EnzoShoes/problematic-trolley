
extends CanvasLayer
signal black_screen
@onready var color_rect: ColorRect = $Control/ColorRect_Fade_to_black
@onready var animation_player: AnimationPlayer = $Control/AnimationPlayer
@onready var color_rect_fade_to_black_2: ColorRect = $Control/ColorRect_Fade_to_black2

func fade_in(trans: String):
	animation_player.play(trans)
	await animation_player.animation_finished
	black_screen.emit()
	if trans == "fade_in":
		animation_player.play_backwards(trans)
