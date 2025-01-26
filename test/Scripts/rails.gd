extends Node2D

var loaded_victims = {
	"top": [],
	"bot": []
}

func calculate_winner() -> String:
	var top_score = 0
	var bot_score = 0
	
	for victim in loaded_victims["top"]:
		top_score += victim.value
		
	for victim in loaded_victims["bot"]:
		bot_score += victim.value
		
	return "top" if top_score > bot_score else "bot"

func spawn_victims(lvl : Dictionary, glitch = Glitch.glitches.NONE) -> void:
	for i in range(len(lvl["top"])):
			var new_victim = VictimFactory.new_victim(lvl["top"][i], glitch)
			var current_spawn_point = get_node("spawn_points/spawn_" + "top" + "/spawn_" + "top" + "_" + str(i+1))
			current_spawn_point.call_deferred("add_child", new_victim)
			loaded_victims["top"].append(new_victim)
	for i in range(len(lvl["bot"])):
			var new_victim = VictimFactory.new_victim(lvl["bot"][i], glitch)
			var current_spawn_point = get_node("spawn_points/spawn_" + "bot" + "/spawn_" + "bot" + "_" + str(i+1))
			current_spawn_point.call_deferred("add_child", new_victim)
			loaded_victims["bot"].append(new_victim)

func free_victims(victims: Dictionary):
	for i in victims["top"]:
		i.queue_free()
	for i in victims["bot"]:
		i.queue_free()
	victims["top"].clear()
	victims["bot"].clear()
