extends CanvasLayer

signal try_play
signal try_quit

func _on_play_pressed() -> void:
	try_play.emit()

func _on_quit_pressed() -> void:
	try_quit.emit()
