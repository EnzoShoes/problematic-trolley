class_name Problem
extends Node2D

@onready var troley: Troley = $troley
@onready var rails: Node2D = $rails


var dialogue_manager : DialogueManager
# Gets set by ProblemManager when Problem is instantiated
var problem_manager: ProblemManager

func _ready() -> void:
	troley.player_chose_side.connect(_on_player_chose_path)

func _on_top_choice_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		if Globals.game_state == Globals.game_states.SUPERVISED or Globals.game_state == Globals.game_states.TUTORIAL:
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
		if Globals.game_state == Globals.game_states.SUPERVISED or Globals.game_state == Globals.game_states.TUTORIAL:
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

func _on_player_chose_path():
	dialogue_manager.print_supervisor_comment_on_choice()
