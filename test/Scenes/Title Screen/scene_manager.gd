extends Node
const GAME = preload("res://Scenes/game.tscn")
@onready var title_screen_ui: CanvasLayer = $"Title screen/title_screen_ui"
@onready var title_screen: Node2D = $"Title screen"


func _ready() -> void:
	title_screen_ui.try_play.connect(_on_play_pressed)
	title_screen_ui.try_quit.connect(_on_quit_pressed)
	
func _on_play_pressed() -> void:
	var game = GAME.instantiate()
	title_screen.queue_free()
	add_child(game)

func _on_quit_pressed() -> void:
	get_tree().quit()
