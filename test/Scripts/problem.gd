extends Node2D

signal choice_made

@onready var background: Node2D = $background
@onready var troley: Node2D = $troley
@onready var rails: Node2D = $rails

func bad_choice():
	print(" bad choice :/")
	choice_made.emit("bad")

func good_choice():
	print(" good choice ;D")
	choice_made.emit("good")

func _on_top_choice_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		if Globals.game_state == Globals.game_states.SUPERVISED:
			if rails.calculate_winner() == "bot":
				good_choice()
			else:
				bad_choice()
		elif Globals.game_state == Globals.game_states.UNSUPERVISED:
			if rails.calculate_winner() == "top":
				good_choice()
			else:
				bad_choice()
			pass

func _on_bot_choice_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		if Globals.game_state == Globals.game_states.SUPERVISED:
			if rails.calculate_winner() == "top":
				good_choice()
			else:
				bad_choice()
		elif Globals.game_state == Globals.game_states.UNSUPERVISED:
			if rails.calculate_winner() == "bot":
				good_choice()
			else:
				bad_choice()
			pass
