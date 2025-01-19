extends Node2D
@onready var area_2d: Area2D = $Area2D
@onready var upper_body: Sprite2D = $dead_limbs/upper_body/Sprite2D
@onready var lower_body: Sprite2D = $dead_limbs/lower_body/Sprite2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var ressource: Resource

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upper_body.texture = ressource.sprite_dead_upper
	lower_body.texture = ressource.sprite_dead_lower
	sprite_2d.texture = ressource.sprite_alive
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
