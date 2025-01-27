extends Node

enum victim_types {BAD, BABY, RICH, OLD, NORMAL, UTIL_MONSTER}

enum game_states {SUPERVISED, UNSUPERVISED, END}
var game_state: int = game_states.SUPERVISED
