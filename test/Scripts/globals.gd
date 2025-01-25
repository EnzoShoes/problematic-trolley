extends Node

enum victim_types {BAD, BABY, RICH, OLD, NORMAL}
enum game_states {SUPERVISED, UNSUPERVISED, END}
var game_state: int = game_states.SUPERVISED
