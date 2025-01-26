extends Control


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var new_glitch = GlitchFactory.new_glitch(Glitch.active_glitch)
