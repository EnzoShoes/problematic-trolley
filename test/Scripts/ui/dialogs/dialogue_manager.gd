class_name DialogueManager
extends CanvasLayer
@export var label: Label
@export var animation_player : AnimationPlayer
@export var input_manger : InputManager
@export var problem_manager : ProblemManager
@export var dialog_clear_timer : Timer
@export var dialogue_arrow : AnimatedSprite2D
@export var music_manager : MusicManager

signal on_next_dialog
enum display_text_features {NONE, NO_AROW}

func _ready() -> void:
	input_manger.space_bar_just_pressed.connect(_on_space_bar_pressed)

func display_text(text:String, feature: display_text_features = display_text_features.NONE):
	visible = true
	label.text = ""
	animation_player.play("display_text")
	label.text = text
	music_manager.talk_supervisor.play()
	await animation_player.animation_finished
	music_manager.talk_supervisor.stop()
	
	problem_manager.no_choice_taken.wait_time = 3
	problem_manager.no_choice_taken.stop()
	
	if feature != display_text_features.NO_AROW:
		dialogue_arrow.visible = true
	
	animation_player.speed_scale = 1

func print_supervisor_comment_on_choice():
	var rando = randi_range(0,100)
	if rando <= 70:
		if Globals.game_state == Globals.game_states.SUPERVISED:
			display_text(DialogFactory.new_random_dialog("comment_on_choice",randi_range(0, len(DialogFactory.random_dialog["comment_on_choice"])-1)), display_text_features.NO_AROW)
			await animation_player.animation_finished
			dialog_clear_timer.start()

func print_tutorial_dialogue(index : int, key : String, key2: String = ""):
	display_text(DialogFactory.new_tutorial_dialog(index, key, key2))
	
	
func clear(type: String = "nudge"):
	if type == "nudge":
		problem_manager.no_choice_taken.start()
	elif type == "no_nudge":
		pass
	label.text = ""
	visible = false
	dialogue_arrow.visible = false
	

func _on_space_bar_pressed():
	if animation_player.is_playing():
		animation_player.speed_scale = 4
	else:
		on_next_dialog.emit()
		dialogue_arrow.visible = false

func print_coffee_break_comment():
	display_text(DialogFactory.new_coffee_dialogue("start_other_breaks"))

func _on_timer_timeout() -> void:
	clear("no_nudge")
