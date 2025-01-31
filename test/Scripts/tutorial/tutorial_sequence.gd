class_name TutorialSequence
extends Node
@export var dialogue_manager : DialogueManager
@export var game : Game
@export var problem_manager : ProblemManager
@export var ui_manager : Ui
@export var music_manager : MusicManager

var tutorial_lvl: int = 1

func run_intro_dialogue():
	for i in range(0, len(DialogFactory.tutorial_dialogue["intro"])):
		game.can_trolley_move = false
		dialogue_manager.print_tutorial_dialogue(i, "intro")
		await dialogue_manager.on_next_dialog
	dialogue_manager.clear()
	game.can_trolley_move = true
	tutorial_lvl += 1

func run_tutorial_dialog():
	var index : int
	if problem_manager.last_choice == "good":
		index = 0
	if problem_manager.last_choice == "bad":
		index = 1
	game.can_trolley_move = false
	dialogue_manager.print_tutorial_dialogue(index, "tutorial", "lvl_" + str(tutorial_lvl))
	await dialogue_manager.on_next_dialog
	dialogue_manager.print_tutorial_dialogue(2, "tutorial", "lvl_" + str(tutorial_lvl))
	await dialogue_manager.on_next_dialog
	if tutorial_lvl == len(LevelFactory.tutorial_lvls_map):
		ui_manager.show_supervised_indicator()
		ui_manager.ui.trust_gauge.visible = true
	dialogue_manager.clear()
	tutorial_lvl += 1
	game.can_trolley_move = true
	if tutorial_lvl >= len(LevelFactory.tutorial_lvls_map)+1:
		Globals.game_state = Globals.game_states.SUPERVISED
		await run_tutorial_outro_dialog()
		
func run_tutorial_outro_dialog():
	for i in range(0, len(DialogFactory.tutorial_dialogue["tutorial_outro"])):
		game.can_trolley_move = false
		dialogue_manager.print_tutorial_dialogue(i, "tutorial_outro")
		await dialogue_manager.on_next_dialog
	dialogue_manager.clear()
	
	game.can_trolley_move = true

func run_coffee_break():
	dialogue_manager.print_coffee_break_comment()
	game.can_trolley_move = false
	await dialogue_manager.on_next_dialog
	dialogue_manager.clear()
	music_manager.supervisor_sigh.play()
	await music_manager.supervisor_sigh.finished
	SceneTransition.animation_player.play("blinking_lights")
	music_manager.sfx_lights_off.play()
	game.can_trolley_move = true
