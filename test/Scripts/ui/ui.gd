class_name Ui
extends Node

@onready var ui: GameUi = $UI
@onready var background: Node2D = $background/Background
@export var score_manager: ScoreManager
@export var music_manager: MusicManager
func _ready() -> void:
	score_manager.freedom_score_updated.connect(_on_freedom_score_updated)
	score_manager.trust_score_updated.connect(_on_trust_score_updated)

func _on_trust_score_updated(score, max_score):
	var trust_gauge_value: float
	trust_gauge_value = 100 * score / max_score
	ui.update_trust_bar(trust_gauge_value)
	
func _on_timer_updates(time_left, _max_time):
	ui.update_timer_label(time_left * 100)

func _on_freedom_score_updated(score, max_score):
	var freedom_gauge_value: float
	freedom_gauge_value = 100 * score / max_score
	ui.update_freedom_bar(freedom_gauge_value)

func show_supervised_indicator():
	ui.supervised_indicator.visible = true
	music_manager.sfx_notification.play()
