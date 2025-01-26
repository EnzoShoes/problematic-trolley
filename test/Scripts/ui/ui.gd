extends Node

@onready var ui: CanvasLayer = $UI
@onready var background: Node2D = $background/Background
@onready var score_manager: Node = $"../Score_manager"

func _ready() -> void:
	score_manager.freedom_score_updated.connect(_on_freedom_score_updated)
	score_manager.trust_score_updated.connect(_on_trust_score_updated)


func _on_trust_score_updated(score, max_score):
	var trust_gauge_value: float
	trust_gauge_value = 100 * score / max_score
	ui.update_trust_bar(trust_gauge_value)

func _on_freedom_score_updated(score, max_score):
	var freedom_gauge_value: float
	freedom_gauge_value = 100 * score / max_score
	ui.update_freedom_bar(freedom_gauge_value)
