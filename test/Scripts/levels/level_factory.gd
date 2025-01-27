class_name LevelFactory
extends Node

static var possible_victims : Array = []:
	get():
		return possible_victims_per_glitch[Glitch.active_glitch]

static var possible_victims_per_glitch : Dictionary = {
	Glitch.glitches.NONE : [Globals.victim_types.BAD, Globals.victim_types.BABY, Globals.victim_types.RICH, Globals.victim_types.OLD, Globals.victim_types.NORMAL],
	Glitch.glitches.AI_UPLOADING : [Globals.victim_types.BAD, Globals.victim_types.BABY, Globals.victim_types.RICH, Globals.victim_types.OLD, Globals.victim_types.NORMAL],
	Glitch.glitches.OPPRESSIVE_SOCIETY : [Globals.victim_types.BAD, Globals.victim_types.BABY, Globals.victim_types.RICH, Globals.victim_types.OLD, Globals.victim_types.NORMAL],
	Glitch.glitches.UTILITY_MONSTER : [Globals.victim_types.BAD, Globals.victim_types.BABY, Globals.victim_types.RICH, Globals.victim_types.OLD, Globals.victim_types.NORMAL, Globals.victim_types.UTIL_MONSTER]
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

static func new_random_lvl() -> Dictionary:
	var random_lvl = {
		"top" : [],
		"bot" : []
	}
	for i in range(randi_range(1,5)):
		random_lvl["top"].append(randi_range(0,len(possible_victims)-1))
	for i in range(randi_range(1,5)):
		random_lvl["bot"].append(randi_range(0,len(possible_victims)-1))
	return random_lvl
