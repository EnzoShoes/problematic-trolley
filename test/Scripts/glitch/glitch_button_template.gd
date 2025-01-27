extends Control

@export var resource: GlitchResource

@onready var bug_description: Label =$"Bug Background/Bug description"
@onready var bug_icon: TextureRect =$"Bug Background/Bug_Icon" 
@onready var glitch_effect: Label = $"Bug Background/glitch_effect"
@onready var glitch_name: Label = $"Bug Background/glitch_name"
@onready var glitch_type: Glitch.glitches = Glitch.glitches.NONE

@onready var UI : GlitchSelection

func _ready() -> void:
	bug_description.text = resource.Bug_description
	bug_icon.texture = resource.bug_icon
	glitch_effect.text = resource.Bug_effect
	glitch_name.text = resource.Bug_name 
	glitch_type = resource.glitch_type


func _on_button_pressed() -> void:
	if glitch_type not in Glitch.aquiered_glitches:
		Glitch.aquiered_glitches.append(glitch_type)
		print(str(glitch_type) + " is now aquiered")
		UI.return_to_game()
