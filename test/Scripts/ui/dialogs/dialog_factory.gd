class_name DialogFactory
extends Node

static var dialogue_file_path: String = "res://Assets/json/Dialogue.json"

static var text_dialogue: Dictionary = {}:
	get():
		print("tring to get textdialogue")
		text_dialogue = load_json_file(dialogue_file_path)
		return text_dialogue

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

static func new_dialog(key : String, index : int) -> String:
	return text_dialogue[key][index]
