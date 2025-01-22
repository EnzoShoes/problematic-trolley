extends CanvasLayer
@onready var color_rect: ColorRect = $Control/ColorRect
@onready var animation_player: AnimationPlayer = $Control/ColorRect/AnimationPlayer



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		fade_in()
	if Input.is_action_just_pressed("ui_cancel"):
		fade_out()

func fade_in():
	animation_player.play("Transition")
	await animation_player.animation_finished
	animation_player.play_backwards("Transition")

func fade_out():
	animation_player.play_backwards("Transition")
	await animation_player.animation_finished
