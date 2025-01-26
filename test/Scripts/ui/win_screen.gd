extends CanvasLayer


func _on_quit_pressed() -> void:
	get_tree().queu_free()
	print("try quit")
	pass # Replace with function body.
