extends Control

@export var resource: GlitchResource

@onready var bug_description: Label =$"Bug Background/Bug description"
@onready var bug_icon: TextureRect =$"Bug Background/Bug_Icon" 
@onready var glitch_effect: Label = $"Bug Background/glitch_effect"
@onready var glitch_name: Label = $"Bug Background/glitch_name"

func _ready() -> void:
	bug_description.text = resource.Bug_description
	bug_icon.texture = resource.bug_icon
	glitch_effect.text = resource.Bug_effect
	glitch_name.text = resource.Bug_name 
