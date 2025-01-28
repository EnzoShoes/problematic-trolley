class_name Glitch
extends Node

enum glitches {
NONE,
AI_UPLOADING, 
OPPRESSIVE_SOCIETY, 
UTILITY_MONSTER, 
IMPATIENT_TROLLEY, 
RECURSIVE_FREEDOM,
UNDERPOPULATION
}

enum glitches_buff {SPEED}


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

static var chose_new_glitch : bool:
	get():
		return chose_new_glitch


static var victim_value_map : Dictionary = {
	glitches.NONE : {
		Globals.victim_types.BAD : 1,
		Globals.victim_types.BABY : 10,
		Globals.victim_types.OLD : 3,
		Globals.victim_types.NORMAL: 5,
		Globals.victim_types.RICH : 15
	},
	glitches.AI_UPLOADING : {
		Globals.victim_types.BAD : 1,
		Globals.victim_types.BABY : 10,
		Globals.victim_types.OLD : 3,
		Globals.victim_types.NORMAL: 5,
		Globals.victim_types.RICH : 0
	},
	glitches.OPPRESSIVE_SOCIETY : {
		Globals.victim_types.BAD : 1,
		Globals.victim_types.BABY : 10,
		Globals.victim_types.OLD : 3,
		Globals.victim_types.NORMAL: 1000,
		Globals.victim_types.RICH : 15
	},
	glitches.UTILITY_MONSTER : {
		Globals.victim_types.BAD : 1,
		Globals.victim_types.BABY : 10,
		Globals.victim_types.OLD : 3,
		Globals.victim_types.NORMAL: 5,
		Globals.victim_types.RICH : 15,
		Globals.victim_types.UTIL_MONSTER : 1000
	}
}

static var glitch_choice_map : Array = [1,2,3,6,9,12]


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
