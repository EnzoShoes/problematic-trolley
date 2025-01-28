class_name TutorialSequence
extends Node
@export var dialogue_manager : DialogueManager
@export var input_manger : InputManager
@export var troley : Troley
	
var tutorial_lvl: int = 1

func run_intro_dialogue():
	for i in range(0, len(DialogFactory.tutorial_dialogue["intro"])):
		troley.in_control = false
		dialogue_manager.print_tutorial_dialogue(i, "intro")
		await input_manger.space_bar_just_pressed
	#troley.in_control = true
func run_tutorial_dialog(lvl: String):
	for i in range(0, len(DialogFactory.tutorial_dialogue["tutorial"][lvl])):
		dialogue_manager.print_tutorial_dialogue(i, "tutorial", lvl)

# Fade in lent
# Dialogue 1
# aparition du premier problem
# dialogue lvl 1
# choix 1
# dialogue lvl 2 
# choix 2
# ...
# choix 5
# dialogue
