extends Node

enum game_states {SUPERVISED, UNSUPERVISED}
var game_state = game_states.SUPERVISED
var freedom_score:int = 0
var best_freedom_score:int = 0
var trust_score:int = 0 
var number_of_phases:int = 5 #number of problem during the monitored phase
const win_requirement = 20 #number of freedom score you need to have in order to activate win sequence
@onready var gauges: Control = $"../Gauges/Control"


func _process(delta: float) -> void:
	debbug_inputs()
	update_ui() 
	check_for_win()
	update_best_freedom_score()

func add_score(points): #adds a point to the right score depending on the phase you are in, you only need to indicate when the player wins and the type of phase and it handles the rest
	if game_state == game_states.SUPERVISED:
		trust_score += points
		print("trust increased")
	elif game_state == game_states.UNSUPERVISED:
		freedom_score += points
		print("freedom increased") 
	else:
		printerr("no conditions met")

func debbug_inputs():
	if Input.is_action_just_pressed("ui_accept"):
		print("adding score")
		add_score(1)

func update_ui(): #pass the value of the score to the gauges so they can be updated in the UI
	var trust_gauge_value = 100 * trust_score / number_of_phases
	gauges.update_progress_bar(trust_gauge_value, 0)

func check_for_win():
	if freedom_score >= win_requirement:
		print("you win")
	pass

func update_best_freedom_score():
	if freedom_score > best_freedom_score:
		best_freedom_score = freedom_score

func _on_good_choice_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		area.monitoring = false
		add_score(1)

func _on_good_choice_area_exited(area: Area2D) -> void:
	area.monitoring = true
	print("exited")
	pass # Replace with function body.
