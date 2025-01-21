extends Node2D

# instantiate with ressource, 

var lvls_map = [
]
var loaded_victims = []
const VICTIM = preload("res://Scenes/victims/victim.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		spawn_victims(randi_range(2, 10), "top")
		spawn_victims(randi_range(2, 10), "bot")
	if Input.is_action_just_pressed("ui_cancel"):
		free_victims(loaded_victims)

func spawn_victims(vic_num: int,vic_side: String) -> void:
	for i in range(vic_num):
			var new_victim = VictimFactory.new_victim()
			var current_spawn_point = get_node("spawn_points/spawn_" + vic_side + "/spawn_" + vic_side + "_" + str(i+1))
			current_spawn_point.add_child(new_victim)
			loaded_victims.append(new_victim)

func free_victims(victims: Array):
	for i in range(len(victims)):
		victims[i].queue_free()
	victims.clear()
