class_name DialogueManager
extends CanvasLayer
@export var label: Label
@export var animation_player : AnimationPlayer
@export var input_manger : InputManager
@export var problem_manager : ProblemManager
@export var dialog_clear_timer : Timer
@export var dialogue_arrow : AnimatedSprite2D

signal on_next_dialog


func _ready() -> void:
	input_manger.space_bar_just_pressed.connect(_on_space_bar_pressed)

func display_text(text:String):
	label.text = ""
	animation_player.play("display_text")
	label.text = text
	await animation_player.animation_finished
	dialogue_arrow.visible = true
	animation_player.speed_scale = 1

func print_supervisor_comment_on_choice():
	if Globals.game_state == Globals.game_states.SUPERVISED:
		display_text(DialogFactory.new_random_dialog("comment_on_choice",randi_range(0, len(DialogFactory.random_dialog["comment_on_choice"])-1)))
		await animation_player.animation_finished
		dialog_clear_timer.start()

func print_tutorial_dialogue(index : int, key : String, key2: String = ""):
	display_text(DialogFactory.new_tutorial_dialog(index, key, key2))
	
	
func clear():
	label.text = ""
	dialogue_arrow.visible = false
	problem_manager.no_choice_taken.start()

func _on_space_bar_pressed():
	if animation_player.is_playing():
		animation_player.speed_scale = 4
	else:
		on_next_dialog.emit()
		dialogue_arrow.visible = false

func _on_timer_timeout() -> void:
	clear()
