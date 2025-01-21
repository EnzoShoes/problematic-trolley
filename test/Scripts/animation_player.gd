extends Node2D
@onready var trolley: AnimatedSprite2D = get_parent()
var direction : Vector2
var old_position: Vector2 = Vector2.LEFT
var has_moved : bool = false

func _ready() -> void:
	if trolley == null:
		printerr("trolley has no parent")

func _process(delta: float) -> void:
	direction = get_dir(old_position, global_position)
	old_position = global_position
	if direction.normalized() == Vector2.RIGHT:
		trolley.frame = 0
	elif  direction.normalized() == Vector2.UP:
		trolley.frame = 4
	elif direction.normalized() == Vector2.DOWN:
		trolley.frame = 2
	elif direction.normalized().y > 0 and direction.normalized().y != 1:
		trolley.frame = 1
	elif direction.normalized().y < 0 and direction.normalized().y != -1:
		trolley.frame = 3
	else:
		trolley.frame = 0

func get_dir(old_pos, new_pos) -> Vector2:
	direction = new_pos - old_pos
	return direction
