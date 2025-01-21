class_name VictimFactory
extends Node

const victim_scene: PackedScene = preload("res://Scenes/victims/victim.tscn")

static var victim_resource_map = {
	Globals.victim_types.BAD : load("res://resources/bad_dude.tres"),
	Globals.victim_types.BABY : load("res://resources/baby.tres"),
	Globals.victim_types.RICH : load("res://resources/rich_dude.tres"),
	Globals.victim_types.OLD : load("res://resources/old_dude.tres"),
	Globals.victim_types.NORMAL : load("res://resources/regular_dude.tres")
}

static var victim_value_map = {
	Globals.victim_types.BAD : 1,
	Globals.victim_types.BABY : 10,
	Globals.victim_types.OLD : 3,
	Globals.victim_types.NORMAL: 5,
	Globals.victim_types.RICH : 15
}

static func new_victim(type: int) -> Victim:
	var victim: Victim = victim_scene.instantiate()
	victim.ressource = victim_resource_map[type]
	victim.value = victim_value_map[type]
	return victim

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
