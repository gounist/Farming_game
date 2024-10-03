extends CharacterBody2D

@onready var animation_player = get_node("AnimationTree")

const Acceleration = 1000
const Max_speed = 125
const Friction = 800

enum {moving, idle, hoe}
var input_vector = Vector2.ZERO
var state : int

func _ready():
	animation_player.active = true

func _process(delta):
	update_animation()

func _physics_process(delta):
	match state:
		moving:
			print(0)
		idle:
			print(1)
		hoe:
			print(2)
	
	input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	if input_vector:
		velocity = velocity.move_toward(input_vector * Max_speed, Acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO,Friction * delta)
		
	
	move_and_slide()

#handle the animation of the player
func update_animation():
	if velocity == Vector2.ZERO:
		animation_player["parameters/conditions/Idle"] = true
		animation_player["parameters/conditions/Run"] = false
	else:
		animation_player["parameters/conditions/Idle"] = false
		animation_player["parameters/conditions/Run"] = true
	if Input.is_action_just_pressed("Hoe"):
		animation_player["parameters/conditions/Hoe"] = true
	else:
		animation_player["parameters/conditions/Hoe"] = false
	
	if input_vector != Vector2.ZERO:
		animation_player["parameters/Idle/blend_position"] = input_vector
		animation_player["parameters/run/blend_position"] = input_vector
		animation_player["parameters/Hoe/blend_position"] = input_vector


