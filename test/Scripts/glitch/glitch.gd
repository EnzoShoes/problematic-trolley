class_name Glitch
extends Node

# glitches that are >= 0 are "activatable" (probability based)
enum glitches {
	NONE = 0,
	AI_UPLOADING = 1, 
	OPPRESSIVE_SOCIETY = 2, 
	UTILITY_MONSTER = 3,
	UNDERPOPULATION = 100,
	RECURSIVE_FREEDOM = 101,
	IMPATIENT_TROLLEY = 102,
}

static var active_glitch: int = glitches.NONE

# glitches not to roll from
static var aquiered_glitches: Array = []

# glitches to roll from
static var not_aquiered_glitches : Array:
	get():
		var not_aquiered : Array = []
		for glitch in glitches.values():
			if glitch not in aquiered_glitches and glitch != 0:
				not_aquiered.append(glitch)
		return not_aquiered

static var glitch_proba: int:
	get(): 
		glitch_proba = len(aquiered_glitches.filter(func(x): return x < 10)) * 20
		if Glitch.glitches.RECURSIVE_FREEDOM in Glitch.aquiered_glitches:
			glitch_proba = int(glitch_proba * 1.5)
		return glitch_proba

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

# ???
static var glitch_choice_map : Array = [5,10,15]

static func roll_for_glitch():
	if Globals.game_state == Globals.game_states.UNSUPERVISED:
		var proba: int = randi_range(0, 100) 
		if proba >= glitch_proba or len(aquiered_glitches.filter(func(x): return x < 10)) == 0:
			glitched = false
			Glitch.active_glitch = glitches.NONE
		else:
			glitched = true
			print("next lvl should be glitched")
			active_glitch = aquiered_glitches.filter(func(x): return x < 10).pick_random()
