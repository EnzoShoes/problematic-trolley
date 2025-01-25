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

static func new_victim(type: int, glitch: int = Glitch.glitches.NONE) -> Victim:
	var victim: Victim = victim_scene.instantiate()
	victim.ressource = victim_resource_map[type]
	victim.value = Glitch.victim_value_map[glitch][type]
	return victim
