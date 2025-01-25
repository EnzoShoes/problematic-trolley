class_name Glitch
extends Node

enum glitches {NONE, AI_UPLOADING}

var active_glitch: int

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
	}
}
