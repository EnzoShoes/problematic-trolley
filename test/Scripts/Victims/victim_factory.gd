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

static var premade_lvls_map = {
	"lvl_1" : {
		"top" : [Globals.victim_types.NORMAL],
		"bot" : [Globals.victim_types.NORMAL, Globals.victim_types.NORMAL, Globals.victim_types.NORMAL, Globals.victim_types.NORMAL, Globals.victim_types.NORMAL]
	},
	"lvl_2" : {
		"top" : [Globals.victim_types.NORMAL],
		"bot" : [Globals.victim_types.OLD]
	},
	"lvl_3" : {
		"top" : [Globals.victim_types.NORMAL],
		"bot" : [Globals.victim_types.BABY]
	},
	"lvl_4" : {
		"top" : [Globals.victim_types.NORMAL, Globals.victim_types.NORMAL, Globals.victim_types.NORMAL],
		"bot" : [Globals.victim_types.BABY]
	},
	"lvl_5" : {
		"top" : [Globals.victim_types.OLD, Globals.victim_types.OLD, Globals.victim_types.OLD, Globals.victim_types.OLD, Globals.victim_types.OLD, Globals.victim_types.OLD, Globals.victim_types.OLD],
		"bot" : [Globals.victim_types.BABY]
	},
} 

static func new_victim(type: int) -> Victim:
	var victim: Victim = victim_scene.instantiate()
	victim.ressource = victim_resource_map[type]
	victim.value = victim_value_map[type]
	return victim
