class_name GlitchSelection
extends CanvasLayer
@export var h_box_container: HBoxContainer 
var game: Game
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		make_glitches(1)

func _ready() -> void:
	make_glitches(3)

func return_to_game():
	game.close_new_glitch_choice()
	pass

func make_glitches(number : int):
	var temp_possible_glitches : Array = Glitch.not_aquiered_glitches
	for i in range(0, number):
		if len(temp_possible_glitches) > 0:
			var rando = randi_range(0, len(temp_possible_glitches)-1)
			var new_glitch = GlitchFactory.new_glitch(temp_possible_glitches[rando])
			temp_possible_glitches.remove_at(rando)
			new_glitch.UI = get_node(".")
			h_box_container.add_child(new_glitch)
		else : 
			print("no more glitches to add")
