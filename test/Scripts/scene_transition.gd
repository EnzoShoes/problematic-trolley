extends CanvasLayer
signal black_screen
@onready var color_rect: ColorRect = $Control/ColorRect_Fade_to_black
@onready var animation_player: AnimationPlayer = $Control/AnimationPlayer

func fade_in(trans: String):
	animation_player.play(trans)
	await animation_player.animation_finished
	black_screen.emit()

func fade_out(trans: String):
	animation_player.play_backwards(trans)
	await animation_player.animation_finished
