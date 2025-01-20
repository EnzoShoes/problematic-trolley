extends Node2D
enum victim_types {BAD, BABY, RICH, OLD, NORMAL}
var victim_map = {
	victim_types.BAD : load("res://resources/bad_dude.tres"),
	victim_types.BABY : load("res://resources/baby.tres"),
	victim_types.RICH : load("res://resources/rich_dude.tres"),
	victim_types.OLD : load("res://resources/old_dude.tres"),
	victim_types.NORMAL : load("res://resources/regular_dude.tres")
}
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
			var new_victim = VICTIM.instantiate()
			new_victim.ressource = victim_map[randi_range(0, len(victim_types)-1)]
			var current_spawn_point = get_node("spawn_points/spawn_" + vic_side + "/spawn_" + vic_side + "_" + str(i+1))
			current_spawn_point.add_child(new_victim)
			loaded_victims.append(new_victim)

func free_victims(victims: Array):
	for i in range(len(victims)):
		victims[i].queue_free()
	victims.clear()
