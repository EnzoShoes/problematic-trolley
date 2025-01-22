extends CanvasLayer
@onready var animation_player = $Control/ColorRect/AnimationPlayer	

func change_scene (target: String) -> void:
	$Control/ColorRect/AnimationPlayer.play("Transition")
	await $Control/ColorRect/AnimationPlayer.animation_finished
	
	$Control/ColorRect/AnimationPlayer.play_backwards("Transition")
