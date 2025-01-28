class_name DialogueManager
extends CanvasLayer
@export var label: Label
@export var animation_player : AnimationPlayer


func display_text(text:String):
	animation_player.play("display_text")
	label.text = text
	await animation_player.animation_finished

func print_supervisor_comment_on_choice():
	display_text(DialogFactory.new_random_dialog("comment_on_choice",randi_range(0, len(DialogFactory.random_dialog["comment_on_choice"])-1)))

func print_tutorial_dialogue(index : int, key : String, key2: String = ""):
	display_text(DialogFactory.new_tutorial_dialog(index, key, key2))
	
