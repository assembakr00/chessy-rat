extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var acceleration = Vector2.ZERO

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	
	
	move_and_slide()
