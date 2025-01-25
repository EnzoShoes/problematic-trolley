class_name VictimFactory
extends Node

const victim_scene: PackedScene = preload("res://Scenes/victims/victim.tscn")

static var victim_resource_map = {
	Globals.victim_types.BAD : load("res://resources/bad_dude.tres"),
	Globals.victim_types.BABY : load("res://resources/baby.tres"),
	Globals.victim_types.RICH : load("res://resources/rich_dude.tres"),
	Globals.victim_types.OLD : load("res://resources/old_dude.tres"),
	Globals.victim_types.NORMAL : load("res://resources/regular_dude.tres")
}

static var victim_shader_map = {
	Glitch.glitches.NONE : null,
	Glitch.glitches.AI_UPLOADING : load("res://resources/Shaders/shader_materials/no_value_victim.tres")
}

static var victim_particles_map = {
	Glitch.glitches.NONE : preload("res://Scenes/particles_systems/empty_node.tscn"),
	Glitch.glitches.AI_UPLOADING : load("res://Scenes/particles_systems/zero_value_particles.tscn")
}
static func new_victim(type: int, glitch: int = Glitch.glitches.NONE) -> Victim:
	var victim: Victim = victim_scene.instantiate()
	victim.ressource = victim_resource_map[type]
	victim.value = Glitch.victim_value_map[glitch][type]
	victim.material = victim_shader_map[glitch]
	var particle_system = victim_particles_map[glitch].instantiate()
	victim.get_node("particle_holder").add_child(particle_system)
	return victim
