extends Control

@export var resource: GlitchResource

@export var bug_description: Label
@export var bug_icon: TextureRect
@export var glitch_effect: Label
@export var glitch_name: Label
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
		# assign to active glitch if it is an activatable glitch
		Glitch.active_glitch = Glitch.glitches.NONE if glitch_type >= 10 else glitch_type
		print(str(glitch_type) + " is now aquiered")
		UI.return_to_game()
