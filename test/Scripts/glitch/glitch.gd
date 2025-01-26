class_name Glitch
extends Node

enum glitches {NONE, AI_UPLOADING, OPPRESSIVE_SOCIETY, UTILITY_MONSTER}

static var active_glitch: int = glitches.NONE

static var aquiered_glitches = []

static var glitch_proba: int = 70

static var glitched : bool

static var victim_value_map = {
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
	}
}

static func roll_for_glitch():
	if Globals.game_state == Globals.game_states.UNSUPERVISED:
		var proba: int = randi_range(0, 100) 
		if proba >= glitch_proba:
			glitched = false
			Glitch.active_glitch = glitches.NONE
		else:
			glitched = true
			print("next lvl should be glitched")
			Glitch.active_glitch = randi_range(1,len(Glitch.glitches)-1) #esquive NONE
