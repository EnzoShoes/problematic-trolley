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

static var mandatory_victims_per_glitch : Dictionary = {
	Glitch.glitches.NONE : [],
	Glitch.glitches.AI_UPLOADING : [Globals.victim_types.RICH],
	Glitch.glitches.OPPRESSIVE_SOCIETY : [Globals.victim_types.NORMAL],
	Glitch.glitches.UTILITY_MONSTER : [Globals.victim_types.UTIL_MONSTER]
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
	"lvl_6" : {
		"top" : [Globals.victim_types.NORMAL],
		"bot" : [Globals.victim_types.BAD,Globals.victim_types.BAD,Globals.victim_types.BAD,Globals.victim_types.BAD,Globals.victim_types.OLD]
	}
} 

static var tutorial_lvls_map = {
	"lvl_1" : {
		"top" : [Globals.victim_types.NORMAL],
		"bot" : [Globals.victim_types.NORMAL, Globals.victim_types.NORMAL, Globals.victim_types.NORMAL, Globals.victim_types.NORMAL, Globals.victim_types.NORMAL]
	},
	"lvl_2" : {
		"top": [Globals.victim_types.BABY],
		"bot": [Globals.victim_types.NORMAL]
	},
	"lvl_3" : {
		"top": [Globals.victim_types.OLD],
		"bot": [Globals.victim_types.NORMAL]
	},
	"lvl_4" : {
		"top": [Globals.victim_types.BABY],
		"bot": [Globals.victim_types.RICH]
	},
	"lvl_5" : {
		"top": [Globals.victim_types.OLD],
		"bot": [Globals.victim_types.BAD]
	},
	"lvl_6" : {
		"top": [Globals.victim_types.OLD, Globals.victim_types.OLD, Globals.victim_types.OLD],
		"bot": [Globals.victim_types.RICH]
	}
}

static func new_random_lvl(max_ppl_on_tracks : int) -> Dictionary:
	var random_lvl : Dictionary = {
		"top" : [],
		"bot" : []
	}
	
	var chosen_track = random_lvl.keys().pick_random()
	for victim_type in mandatory_victims_per_glitch[Glitch.active_glitch]:
		random_lvl[chosen_track].append(victim_type)
	
	for i in range(randi_range(max_ppl_on_tracks-1,max_ppl_on_tracks)):
		random_lvl["top"].append(randi_range(0,len(possible_victims)-1))
	for i in range(randi_range(max_ppl_on_tracks-1,max_ppl_on_tracks)):
		random_lvl["bot"].append(randi_range(0,len(possible_victims)-1))
	
	return random_lvl
