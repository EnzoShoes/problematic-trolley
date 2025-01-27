class_name ProblemManager
extends Node

@export var game: Game
@export var score_manager: ScoreManager
@export var music_manager: Node
@export var ui_manager: Node

@onready var PROBLEM = preload("res://Scenes/problem.tscn")

func new_problem_scene() -> Node:
	var problem_scene : Problem = PROBLEM.instantiate()
	problem_scene.problem_manager = self
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
	score_manager.add_score(1)
	if Globals.game_state == Globals.game_states.UNSUPERVISED:
		_play_unsupervied_music()
	music_manager.sfx_good_choice.play()
	ui_manager.background.flash("Good_Choice")
	await ui_manager.background.animation_finished
	
func _handle_bad_choice():
	ui_manager.background.flash("Bad_Choice")
	music_manager.sfx_bad_choice.play()
	await ui_manager.background.animation_finished
	
func _play_unsupervied_music():
	if !music_manager.frenzy.playing:
		music_manager.music_play("unsupervised")
