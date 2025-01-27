extends Control

var DialogueText = {}
var DialogueFilePath = "res://Assets/json/Dialogue.json"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueText = load_json_file(DialogueFilePath)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_json_file(filePath):
	if FileAccess.file_exists(filePath):
		var file = FileAccess.open(filePath, FileAccess.READ)
		var fileparsed = JSON.parse_string(file.get_as_text())
		return fileparsed
	else:
		print("nonono, no file in the path :/")
