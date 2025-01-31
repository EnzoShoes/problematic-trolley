class_name  InputManager
extends Node

@export var ui : GameUi
@export var problem_manger : ProblemManager
signal space_bar_just_pressed
@onready var tutorial_sequence: TutorialSequence = $"../tutorial_sequence"

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		space_bar_just_pressed.emit()
	if Input.is_action_just_pressed("down") or Input.is_action_just_pressed("up"):
		problem_manger.no_choice_taken.wait_time = 3
		problem_manger.no_choice_taken.stop()
		ui.input_nudge.visible = false
	debug_inputs()

func debug_inputs():
	if Input.is_action_just_pressed("ui_cancel"):
		Globals.game_state = Globals.game_states.UNSUPERVISED
		tutorial_sequence.run_coffee_break()
