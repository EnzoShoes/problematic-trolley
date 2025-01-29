class_name Glitch
extends Node

enum glitches {
	NONE,
	AI_UPLOADING, 
	OPPRESSIVE_SOCIETY, 
	UTILITY_MONSTER, 
}

enum glitches_buff {UNDERPOPULATION, RECURSIVE_FREEDOM, IMPATIENT_TROLLEY,}


static var active_glitch: int = glitches.NONE

static var aquiered_glitches: Array = []

static var not_aquiered_glitches : Array:
	get():
		var not_aquiered : Array = []
		for glitch in glitches.values():
			if glitch not in aquiered_glitches and glitch != 0:
				not_aquiered.append(glitch)
		return not_aquiered

static var glitch_proba: int = 70

static var glitched : bool

static var victim_value_map : Dictionary = {
	glitches.NONE : {
		Globals.victim_types.BAD : -1,
		Globals.victim_types.BABY : 3,
		Globals.victim_types.OLD : 1,
		Globals.victim_types.NORMAL: 2,
		Globals.victim_types.RICH : 4
	},
	glitches.AI_UPLOADING : {
		Globals.victim_types.BAD : -1,
		Globals.victim_types.BABY : 3,
		Globals.victim_types.OLD : 1,
		Globals.victim_types.NORMAL: 2,
		Globals.victim_types.RICH : 0
	},
	glitches.OPPRESSIVE_SOCIETY : {
		Globals.victim_types.BAD : -1,
		Globals.victim_types.BABY : 3,
		Globals.victim_types.OLD : 1,
		Globals.victim_types.NORMAL: 100,
		Globals.victim_types.RICH : 4
	},
	glitches.UTILITY_MONSTER : {
		Globals.victim_types.BAD : -1,
		Globals.victim_types.BABY : 3,
		Globals.victim_types.OLD : 1,
		Globals.victim_types.NORMAL: 2,
		Globals.victim_types.RICH : 4,
		Globals.victim_types.UTIL_MONSTER : 10000
	}
}

static var glitch_choice_map : Array = [5,10,15]


static func roll_for_glitch():
	if Globals.game_state == Globals.game_states.UNSUPERVISED:
		var proba: int = randi_range(0, 100) 
		if proba >= glitch_proba or len(aquiered_glitches) == 0:
			glitched = false
			Glitch.active_glitch = glitches.NONE
		else:
			glitched = true
			print("next lvl should be glitched")
			var rando = randi_range(0, len(aquiered_glitches)-1)
			active_glitch = aquiered_glitches[rando]
