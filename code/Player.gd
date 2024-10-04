extends CharacterBody2D

@onready var animation_player = get_node("AnimationTree")

const Acceleration = 1000
const Max_speed = 125
const Friction = 800

enum {moving, hoe}
var input_vector = Vector2.ZERO
var state : int
var using_hoe : bool = false

func _ready():
	animation_player.active = true

func _process(delta):
	update_animation()

func _physics_process(delta):
	match state:
		moving:
			player_movement(delta)
			
		hoe:
			pass
	


func player_movement(delta):
	input_vector = get_input()
	
	if input_vector:
		velocity = velocity.move_toward(input_vector * Max_speed, Acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO,Friction * delta)
	
	move_and_slide()

#getting player input
func get_input():
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	return input_vector.normalized()

#handle the animation of the player
func update_animation():
	if velocity == Vector2.ZERO:
		animation_player["parameters/conditions/Idle"] = true
		animation_player["parameters/conditions/Run"] = false
	else:
		animation_player["parameters/conditions/Idle"] = false
		animation_player["parameters/conditions/Run"] = true
	if Input.is_action_just_pressed("Hoe") and state == moving:
		using_hoe = true
		animation_player["parameters/conditions/Hoe"] = true
	else:
		animation_player["parameters/conditions/Hoe"] = false
	
	if input_vector != Vector2.ZERO:
		animation_player["parameters/Idle/blend_position"] = input_vector
		animation_player["parameters/run/blend_position"] = input_vector
		animation_player["parameters/Hoe/blend_position"] = input_vector

func check_hoe():
	if using_hoe:
		state = hoe
		using_hoe = false
		return
	state = moving
	return
