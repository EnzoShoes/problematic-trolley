class_name ActivieGlitchShowing
extends CanvasLayer

@export var icon: Texture2D
@onready var icon_2: TextureRect = $Center/Icon


func _ready() -> void:
	icon = GlitchFactory.glitch_resource_map[Glitch.active_glitch].bug_icon
	icon_2.texture = icon
