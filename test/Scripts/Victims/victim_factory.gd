class_name VictimFactory
extends Node

const victim_scene: PackedScene = preload("res://Scenes/victims/victim.tscn")
const ZERO_VALUE_PARTICLES = preload("res://Scenes/particles_systems/zero_value_particles.tscn")

static var victim_resource_map = {
	Globals.victim_types.BAD : load("res://resources/bad_dude.tres"),
	Globals.victim_types.BABY : load("res://resources/baby.tres"),
	Globals.victim_types.RICH : load("res://resources/rich_dude.tres"),
	Globals.victim_types.OLD : load("res://resources/old_dude.tres"),
	Globals.victim_types.NORMAL : load("res://resources/regular_dude.tres")
}

static var victim_shader_map = {
	Glitch.glitches.AI_UPLOADING : load("res://resources/Shaders/shader_materials/no_value_victim.tres")
}

static func new_victim(type: int, glitch: int = Glitch.glitches.AI_UPLOADING) -> Victim:
	var victim: Victim = victim_scene.instantiate()
	victim.ressource = victim_resource_map[type]
	victim.value = Glitch.victim_value_map[glitch][type]
	victim.material = victim_shader_map[glitch]
	var particle_system = ZERO_VALUE_PARTICLES.instantiate()
	victim.get_node("particle_holder").add_child(particle_system)
	return victim
