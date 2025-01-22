extends Node2D

var in_control : bool = true
var trolley : AnimatedSprite2D = null
var initialTrolleyPos : Vector2 = Vector2.ZERO
var speed = 0.8
var path_selected : PathFollow2D = null

func _ready() -> void:
	trolley = $Trolley
	initialTrolleyPos = trolley.position
	pass # Replace with function body.
	
func _process(delta: float) -> void:
	update_trolley_path()
	if (path_selected != null):
		path_selected.progress_ratio += delta * speed * ((path_selected.progress_ratio + 0.1))
		if (path_selected.progress_ratio == 1):
			# Detach trolley from path and reset position
			trolley.position = initialTrolleyPos
			trolley.get_parent().remove_child(trolley)
			add_child(trolley)
			# Reset selected path
			path_selected.progress_ratio = 0
			path_selected = null

func input_manager():
	pass

func update_trolley_path():
	if (path_selected == null) and in_control:
		if (Input.is_action_just_pressed("down")):
			path_selected = $DownPath/PathFollow2D
			
		elif (Input.is_action_just_pressed("up")):
			path_selected = $UpPath/PathFollow2D
		else:
			return
			
		if trolley.get_parent() != null:
			trolley.get_parent().remove_child(trolley)
		
		path_selected.add_child(trolley)
		trolley.transform = Transform2D.IDENTITY	
