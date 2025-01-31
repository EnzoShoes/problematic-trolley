extends PathFollow2D

func _process(delta: float) -> void:
	progress += 100 * delta
