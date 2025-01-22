class_name Victim
extends Node2D

@onready var area_2d: Area2D = $Area2D
@onready var upper_body_sprite: Sprite2D = $dead_limbs/upper_body/Sprite2D
@onready var lower_body_sprite: Sprite2D = $dead_limbs/lower_body/Sprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var upper_body: RigidBody2D = $dead_limbs/upper_body
@onready var lower_body: RigidBody2D = $dead_limbs/lower_body
@onready var blood_explosion: AnimatedSprite2D = $blood_explosion
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@export var ressource: Resource
@export var value: int

var explosion_force: int = 100
var explosion_randomness: float = 0.5 #0 = no random ; 1 = full random
var is_living : bool = true

const anim_speed_rand:float = 0.1

func _ready() -> void:
	# loading the textures from the chosen ressource file because many resources could be used, this script is the same for all types of victims
	upper_body_sprite.texture = ressource.sprite_dead_upper
	lower_body_sprite.texture = ressource.sprite_dead_lower
	animated_sprite_2d.sprite_frames = ressource.sprite_alive 	#loading the anim
	animated_sprite_2d.play("default", randf_range(1-anim_speed_rand,1+anim_speed_rand))	#playing the anim with rand speed
	animated_sprite_2d.frame = randi_range(0, animated_sprite_2d.sprite_frames.get_frame_count("default")-1) #starting anim at random frame

func death():
	animated_sprite_2d.visible = false #makes the main sprite go away because the character is dead and we want to display the dead sprite
	if ressource.have_dead_limbs:
		lower_body.visible = true #displays the dead sprites
		upper_body.visible = true
	
	#create the impulse and adds randomness to it
	lower_body.apply_impulse((Vector2.DOWN +Vector2(randf_range(-explosion_randomness,explosion_randomness),0)) * explosion_force, Vector2(randf_range(-explosion_randomness,explosion_randomness), randf_range(-explosion_randomness,explosion_randomness)))
	upper_body.apply_impulse((Vector2.UP +Vector2(randf_range(-explosion_randomness,explosion_randomness),0)) * explosion_force, Vector2(randf_range(-explosion_randomness,explosion_randomness), randf_range(-explosion_randomness,explosion_randomness)))

	# victim is dead so we want blood to erupt from it
	blood_explosion.visible = true
	blood_explosion.play("blood_explosion")
	#we want to make a stain of blood appear, so its not too repetitive there is a random selection
	var chosen_blood : int = randi_range(1,4)
	var chosen_blood_node = get_node("Node2D/blood_"+ str(chosen_blood))
	chosen_blood_node.visible = true
	
	# plays the sound of the death of the victim
	if audio_stream_player.playing == false:
		audio_stream_player.play()
	
	is_living = false # the victim is dead so we dont want the train to be able to trigger death method again so we turn off the area2D for good


func _on_area_2d_area_entered(area: Area2D) -> void: #triggers the death method when the victim is hit by the train
	print("area entered in victim")
	if area.is_in_group("player"):
		if is_living:
			death()
