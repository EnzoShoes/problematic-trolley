extends AudioStreamPlayer

func _process(_delta: float) -> void:
	if playing == false:
		_set_playing(true)
	else:
		pass
