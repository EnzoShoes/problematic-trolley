class_name Troley
extends Node2D
signal player_chose_side


var in_control : bool = true
@onready var trolley: Node2D = %Trolley
var speed: float = 0.8
	#get():
		#if Glitch.glitches.IMPATIENT_TROLLEY in Glitch.aquiered_glitches:
			#return 1.5
		#return 0.8

var path_selected : PathFollow2D = null

func _ready() -> void:
	update_control_status()
	pass # Replace with function body.

func _process(delta: float) -> void:
	update_trolley_path()
	if (path_selected != null):
		path_selected.progress_ratio += delta * speed * ((path_selected.progress_ratio + 0.1))
		if Glitch.glitches.IMPATIENT_TROLLEY in Glitch.aquiered_glitches:
			path_selected.progress_ratio += delta * speed
		if (path_selected.progress_ratio == 1):
			pass

func update_trolley_path():
	if (path_selected == null) and in_control:
		if (Input.is_action_just_pressed("down")):
			player_chose_side.emit()
			path_selected = $DownPath/PathFollow2D
		elif (Input.is_action_just_pressed("up")):
			player_chose_side.emit()
			path_selected = $UpPath/PathFollow2D
		else:
			return
			
		if trolley.get_parent() != null:
			trolley.get_parent().remove_child(trolley)
		
		path_selected.add_child(trolley)
		trolley.transform = Transform2D.IDENTITY	

func update_control_status():
	if Globals.game_state == Globals.game_states.END:
		in_control = false
