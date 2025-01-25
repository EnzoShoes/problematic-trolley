class_name LevelFactory
extends Node

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

static func new_random_lvl() -> Dictionary:
	var random_lvl = {
		"top" : [],
		"bot" : []
	}
	for i in range(randi_range(1,5)):
		random_lvl["top"].append(randi_range(0,len(Globals.victim_types)-1))
	for i in range(randi_range(1,5)):
		random_lvl["bot"].append(randi_range(0,len(Globals.victim_types)-1))
	return random_lvl
