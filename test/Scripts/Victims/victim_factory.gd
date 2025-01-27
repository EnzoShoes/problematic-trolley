class_name VictimFactory
extends Node

const victim_scene: PackedScene = preload("res://Scenes/victims/victim.tscn")

static var victim_resource_map = {
	Globals.victim_types.BAD : preload("res://resources/bad_dude.tres"),
	Globals.victim_types.BABY : preload("res://resources/baby.tres"),
	Globals.victim_types.RICH : preload("res://resources/rich_dude.tres"),
	Globals.victim_types.OLD : preload("res://resources/old_dude.tres"),
	Globals.victim_types.NORMAL : preload("res://resources/regular_dude.tres"),
	Globals.victim_types.UTIL_MONSTER : preload("res://resources/util_monster.tres")
}

static var victim_shader_map = {
	Glitch.glitches.NONE : null,
	Glitch.glitches.AI_UPLOADING : preload("res://resources/Shaders/shader_materials/no_value_victim.tres"),
	Glitch.glitches.OPPRESSIVE_SOCIETY : preload("res://resources/Shaders/shader_materials/high_value_victim.tres"),
	Glitch.glitches.UTILITY_MONSTER : preload("res://resources/Shaders/shader_materials/high_value_victim.tres")
}

static var victim_particles_map = {
	Glitch.glitches.NONE : preload("res://Scenes/particles_systems/empty_node.tscn"),
	"zero_value" : preload("res://Scenes/particles_systems/zero_value_particles.tscn")
}
static func new_victim(type: int, glitch: int = Glitch.glitches.NONE) -> Victim:
	var victim: Victim = victim_scene.instantiate()
	victim.ressource = victim_resource_map[type]
	victim.value = Glitch.victim_value_map[glitch][type]
	if victim.value <= 0:
		victim.material = victim_shader_map[glitch]
		var particle_system = victim_particles_map["zero_value"].instantiate()
		victim.get_node("particle_holder").add_child(particle_system)
	if victim.value >= 1000:
		victim.material = victim_shader_map[glitch]
		var particle_system = victim_particles_map["zero_value"].instantiate()
		victim.get_node("particle_holder").add_child(particle_system)
	return victim
