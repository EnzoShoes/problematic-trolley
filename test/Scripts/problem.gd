class_name Problem
extends Node2D

@onready var troley: Troley = $troley
@onready var rails: Node2D = $rails

# Gets set by ProblemManager when Problem is instantiated
var problem_manager: Node

func _on_top_choice_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		if Globals.game_state == Globals.game_states.SUPERVISED:
			if rails.calculate_winner() == "bot":
				problem_manager.on_choice_made("good")
			else:
				problem_manager.on_choice_made("bad")
		elif Globals.game_state == Globals.game_states.UNSUPERVISED:
			if rails.calculate_winner() == "top":
				problem_manager.on_choice_made("good")
			else:
				problem_manager.on_choice_made("bad")
			pass

func _on_bot_choice_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		if Globals.game_state == Globals.game_states.SUPERVISED:
			if rails.calculate_winner() == "top":
				problem_manager.on_choice_made("good")
			else:
				problem_manager.on_choice_made("bad")
		elif Globals.game_state == Globals.game_states.UNSUPERVISED:
			if rails.calculate_winner() == "bot":
				problem_manager.on_choice_made("good")
			else:
				problem_manager.on_choice_made("bad")
			pass
