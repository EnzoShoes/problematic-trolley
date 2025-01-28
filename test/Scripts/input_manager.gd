class_name  InputManager
extends Node

signal space_bar_just_pressed

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		space_bar_just_pressed.emit()
