extends Control

@onready var trust_gauge: TextureProgressBar = $Trust_Gauge
@onready var freedom_gauge: TextureProgressBar = $Freedom_Gauge
@onready var label: Label = $Label
@onready var end_of_game_score: Label = $end_of_game_score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_progress_bar(trust_progress_value, freedom_progress_value):
	trust_gauge.value = trust_progress_value
	freedom_gauge.value = freedom_progress_value

func update_timer_label(time_left:int):
	var minutes:int = round((time_left - (time_left % 60)) / 60)
	var seconds:int = time_left % 60
	if seconds < 10:
		label.text = str(minutes)+":0"+str(seconds)
	else:
		label.text = str(minutes)+":"+str(seconds)

func end_game(score:int, max_score:int):
	end_of_game_score.visible = true
	end_of_game_score.text = "your score is : " + str(score) + " / " + str(max_score)
