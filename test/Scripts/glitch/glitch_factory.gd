class_name GlitchFactory

const GLITCH_BUTTON_TEMPLATE = preload("res://Scenes/glitchs/glitch_button_template.tscn")

static var glitch_resource_map = {
	Glitch.glitches.UNDERPOPULATION : preload("res://resources/glitchs/Underpopulation.tres"),
	Glitch.glitches.RECURSIVE_FREEDOM : preload("res://resources/glitchs/Recursive_Freedom.tres"),
	Glitch.glitches.IMPATIENT_TROLLEY : preload("res://resources/glitchs/Impatient_Trolley.tres"),
	Glitch.glitches.AI_UPLOADING : preload("res://resources/glitchs/IA_uploading.tres"),
	Glitch.glitches.OPPRESSIVE_SOCIETY : preload("res://resources/glitchs/oppressive_society.tres"),
	Glitch.glitches.UTILITY_MONSTER : preload("res://resources/glitchs/utility_monster.tres")
}

#static var retard_map = {
	#"Underpopulation" : Glitch.glitches.UNDERPOPULATION,
	#"Recursive Freedom" : Glitch.glitches.RECURSIVE_FREEDOM,
	#"Impatient Trolley" : Glitch.glitches.IMPATIENT_TROLLEY,
	#"IA Uploading" : Glitch.glitches.AI_UPLOADING,
	#"Utility monster" : Glitch.glitches.UTILITY_MONSTER,
	#"Oppressive Society" : Glitch.glitches.OPPRESSIVE_SOCIETY
#}

static func new_glitch(type : Glitch.glitches):
	var glitch = GLITCH_BUTTON_TEMPLATE.instantiate()
	glitch.resource = glitch_resource_map[type]
	glitch.resource.glitch_type = type
	print("glitch type: " + str(glitch.resource.glitch_type))
	return glitch
