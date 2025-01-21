extends Control

@onready var trust_gauge: TextureProgressBar = $Trust_Gauge
@onready var freedom_gauge: TextureProgressBar = $Freedom_Gauge

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_progress_bar(trust_progress_value, freedom_progress_value):
	trust_gauge.value = trust_progress_value
	freedom_gauge.value = freedom_progress_value
