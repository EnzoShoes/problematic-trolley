class_name DialogueManager
extends CanvasLayer
@export var label: Label

func display_text(text:String):
	label.text = text

func print_supervisor_comment_on_choice():
	display_text(DialogFactory.new_dialog("comment_on_choice",randi_range(0, len(DialogFactory.text_dialogue["comment_on_choice"])-1)))
