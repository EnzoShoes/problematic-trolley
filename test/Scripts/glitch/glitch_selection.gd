extends CanvasLayer
@export var h_box_container: HBoxContainer 

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var rando = randi_range(0, len(Glitch.not_aquiered_glitches)-1)
		var new_glitch = GlitchFactory.new_glitch(Glitch.not_aquiered_glitches[rando])
		h_box_container.add_child(new_glitch)
