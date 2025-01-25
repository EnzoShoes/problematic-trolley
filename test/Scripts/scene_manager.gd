extends Node
const GAME = preload("res://Scenes/game.tscn")
@onready var title_screen_ui: CanvasLayer = $"Title screen/title_screen_ui"
@onready var title_screen: Node2D = $"Title screen"
const WIN_SCREEN = preload("res://Scenes/win_screen.tscn")
var current_scene

func _ready() -> void:
	title_screen_ui.try_play.connect(_on_play_pressed)
	title_screen_ui.try_quit.connect(_on_quit_pressed)
	
func _on_play_pressed() -> void:
	var game = GAME.instantiate()
	title_screen.queue_free()
	add_child(game)
	current_scene = game
	game.score_manager.game_win.connect(_on_win)

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_win() -> void:
	Globals.game_state = Globals.game_states.END
	var win_screen = WIN_SCREEN.instantiate()
	current_scene.queue_free()
	add_child(win_screen)
	current_scene = win_screen
	print("YOU WIN !!!")
