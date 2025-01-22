extends CanvasLayer


func change_scene (target: String) -> void:
	$Control/ColorRect/AnimationPlayer.play("Transition")
	await $Control/ColorRect/AnimationPlayer.animation_finished("Transition")
	
	$Control/ColorRect/AnimationPlayer.play_backwards("Transition")
