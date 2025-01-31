class_name ProblemManager
extends Node

@export var game: Game
@export var score_manager: ScoreManager
@export var music_manager: Node
@export var ui_manager: Node
@export var dialogue_manager: DialogueManager
@export var game_ui: GameUi
@onready var PROBLEM = preload("res://Scenes/problem.tscn")
@export var no_choice_taken : Timer

var last_choice: String

func new_problem_scene() -> Node:
	var problem_scene : Problem = PROBLEM.instantiate()
	problem_scene.problem_manager = self
	problem_scene.dialogue_manager = dialogue_manager
	return problem_scene

func on_choice_made(choice: String):
	if choice == "good":
		await _handle_good_choice()
	elif choice == "bad":
		await _handle_bad_choice()
		
	if Globals.game_state == Globals.game_states.SUPERVISED:
		score_manager.num_choice_made += 1
	await score_manager.check_for_new_glitch_choice(score_manager.best_free_score, Glitch.glitch_choice_map, Glitch.not_aquiered_glitches)
	score_manager.prepare_next_problem()

func _handle_good_choice():
	last_choice = "good"
	score_manager.add_score(1)
	if Globals.game_state == Globals.game_states.UNSUPERVISED:
		_play_unsupervied_music()
		SceneTransition.color_rect_fade_to_black_2.modulate = Color(0,0,0,0)
		ui_manager.background.flash("Good_Choice_Frenzy")
		music_manager.sfx_good_choice_frenzy.play()
	else:
		ui_manager.background.flash("Good_Choice")
		music_manager.sfx_good_choice.play()
	await ui_manager.background.animation_finished
	
func _handle_bad_choice():
	last_choice = "bad"
	ui_manager.background.flash("Bad_Choice")
	music_manager.sfx_bad_choice.play()
	await ui_manager.background.animation_finished
	
func _play_unsupervied_music():
	if !music_manager.frenzy.playing:
		music_manager.music_play("unsupervised")

func _on_no_choice_taken():
	game_ui.input_nudge.visible = true
