extends CanvasLayer

@onready var trust_gauge: TextureProgressBar = $Control/Trust_Gauge
@onready var freedom_gauge: TextureProgressBar = $Control/Freedom_Gauge
@onready var timer_clock: Label = $Control/timer_clock
@onready var end_of_game_score: Label = $Control/end_of_game_score
@onready var supervised_indicator: Control = $supervised_indicator


func update_trust_bar(trust_progress_value, freedom_progress_value):
	trust_gauge.value = trust_progress_value
	freedom_gauge.value = freedom_progress_value
	print("trus prog = " + str(trust_progress_value))

@warning_ignore("integer_division")
func update_timer_label(time_left:int):
	var minutes:int = (time_left - (time_left % 60)) / 60
	var seconds:int = time_left % 60
	if seconds < 10:
		timer_clock.text = str(minutes)+":0"+str(seconds)
	else:
		timer_clock.text = str(minutes)+":"+str(seconds)

func end_game(score:int, max_score:int):
	end_of_game_score.visible = true
	end_of_game_score.text = "your score is : " + str(score) + " / " + str(max_score)

func check_game_phase():
	if Globals.game_state == Globals.game_states.UNSUPERVISED:
		timer_clock.visible = true
		supervised_indicator.visible = false
	elif Globals.game_state == Globals.game_states.SUPERVISED:
		timer_clock.visible = false
		supervised_indicator.visible = true

func update_freedom_bar_visble():
	if Globals.game_state == Globals.game_states.UNSUPERVISED:
		freedom_gauge.visible = true
	elif Globals.game_state == Globals.game_states.SUPERVISED:
		freedom_gauge.visible = false
	else: 
		return
