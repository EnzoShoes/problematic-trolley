extends Node

enum victim_types {BAD, BABY, RICH, OLD, NORMAL, UTIL_MONSTER}

enum game_states {SUPERVISED, UNSUPERVISED, END, GLITCH_CHOICE, TUTORIAL}

var game_state: game_states = game_states.TUTORIAL:
	set(value):
		old_game_state = game_state
		game_state = value

var old_game_state: game_states

# used to know if we can generate a new problem
var play_states: Array = [game_states.SUPERVISED, game_states.UNSUPERVISED]
