extends Node2D
@onready var area_2d: Area2D = $Area2D
@onready var upper_body_sprite: Sprite2D = $dead_limbs/upper_body/Sprite2D
@onready var lower_body_sprite: Sprite2D = $dead_limbs/lower_body/Sprite2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var upper_body: RigidBody2D = $dead_limbs/upper_body
@onready var lower_body: RigidBody2D = $dead_limbs/lower_body
@onready var blood_explosion: AnimatedSprite2D = $blood_explosion
@onready var blood_1: Sprite2D = $Node2D/blood_1
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@export var ressource: Resource
var explosion_force: int = 100
var explosion_randomness: float = 0.5 #0 = no random ; 1 = full random
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upper_body_sprite.texture = ressource.sprite_dead_upper
	lower_body_sprite.texture = ressource.sprite_dead_lower
	sprite_2d.texture = ressource.sprite_alive
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("ui_accept"):
		#death()

	pass

func death():
	sprite_2d.visible = false
	lower_body.visible = true
	upper_body.visible = true
	# I want to add randomness to the impulse so it is more realistic but cant manage to do it 
	lower_body.apply_impulse((Vector2.DOWN +Vector2(randf_range(-explosion_randomness,explosion_randomness),0)) * explosion_force, Vector2(randf_range(-explosion_randomness,explosion_randomness), randf_range(-explosion_randomness,explosion_randomness)))

	upper_body.apply_impulse((Vector2.UP +Vector2(randf_range(-explosion_randomness,explosion_randomness),0)) * explosion_force, Vector2(randf_range(-explosion_randomness,explosion_randomness), randf_range(-explosion_randomness,explosion_randomness)))

	blood_explosion.visible = true
	blood_explosion.play("blood_explosion")
	
	var chosen_blood : int = randi_range(1,4)
	print(chosen_blood)
	var chosen_blood_node = get_node("Node2D/blood_"+ str(chosen_blood))
	chosen_blood_node.visible = true
	
	if audio_stream_player.playing == false:
		audio_stream_player.play()
	
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("area entered in victim")
	if area.is_in_group("player"):
		death()
		return
	else:
		print("area wasnt the player")
		return
