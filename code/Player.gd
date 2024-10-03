extends CharacterBody2D

const Acceleration = 1000
const Max_speed = 125
const Friction = 800

@onready var animation_player = get_node("AnimationTree")



func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	 
	if input_vector:
		velocity = velocity.move_toward(input_vector * Max_speed, Acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO,Friction * delta)
	
	move_and_slide()
	






