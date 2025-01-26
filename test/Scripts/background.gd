extends Node2D
signal animation_finished

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func flash(type: String):
	animation_player.play(type)
	await animation_player.animation_finished
	animation_finished.emit()
