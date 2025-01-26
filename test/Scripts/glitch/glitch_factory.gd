class_name GlitchFactory

const GLITCH_BUTTON_TEMPLATE = preload("res://Scenes/glitchs/glitch_button_template.tscn")

static var glitch_resource_map = {
	Glitch.glitches.AI_UPLOADING : preload("res://resources/glitchs/IA_uploading.tres"),
	Glitch.glitches.OPPRESSIVE_SOCIETY : preload("res://resources/glitchs/oppressive_society.tres"),
	Glitch.glitches.UTILITY_MONSTER : preload("res://resources/glitchs/utility_monster.tres")
}

static func new_glitch(type : Glitch.glitches):
	var glitch = GLITCH_BUTTON_TEMPLATE.instantiate()
	glitch.resource = glitch_resource_map[type]
	return glitch
