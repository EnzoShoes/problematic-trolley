class_name DialogFactory
extends Node

static var tutorial_dialogue_path: String = "res://Assets/json/Tutorial_Dialogue.json"
static var random_dialog_path: String = "res://Assets/json/Dialogue.json"

static var tutorial_dialogue: Dictionary = load_json_file(tutorial_dialogue_path)
static var random_dialog: Dictionary = load_json_file(random_dialog_path)


static func load_json_file(filePath) -> Dictionary: 
	print("load_json_entered")
	if FileAccess.file_exists(filePath):
		print("json found")
		var file = FileAccess.open(filePath, FileAccess.READ)
		print(file)
		var fileparsed = JSON.parse_string(file.get_as_text())
		print(fileparsed)
		return fileparsed
	else:
		print("nonono, no file in the path :/")
		var empty_dic = {}
		return empty_dic

static func new_tutorial_dialog( index : int, key : String, key2 : String = "") -> String:
	
	if key2 == "":
		return tutorial_dialogue[key][index]
	return tutorial_dialogue[key][key2][index]

static func new_random_dialog(key : String, index : int) -> String:
	return random_dialog[key][index]

static func new_coffee_dialogue(key : String):
	return random_dialog["coffee_breaks"][key][randi_range(0, len(random_dialog["coffee_breaks"][key])-1)]
