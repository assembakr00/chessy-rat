extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var rat_sprite: AnimatedSprite2D = $Ratplayer

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED

	move_and_slide()

	if not is_zero_approx(direction):
		rat_sprite.flip_h = direction < 0

	if not is_on_floor():
		rat_sprite.play("jump")
	elif not is_zero_approx(direction):
		rat_sprite.play("walk")
	else:
		rat_sprite.play("idle")
