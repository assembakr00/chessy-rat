extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var time_left = 600

var cheese_collected = 0
var max_cheese = 20 # Total number of cheeses hidden

@onready var rat_sprite: AnimatedSprite2D = $RatPlayer


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

func _process(delta: float) -> void:
	# When you lose
	if time_left <= 0:
		get_tree().call_deferred("change_scene_to_file", "res://scenes/lose_menu.tscn")
	
	# When you win
	if cheese_collected == max_cheese:
		get_tree().call_deferred("change_scene_to_file", "res://scenes/win_menu.tscn")

func collect_cheese():
	cheese_collected += 1
	$CheeseNotifier.show()
	$CheeseNotifier/NotifierTimer.start()

func _on_countdown_timer_timeout() -> void:
	# Decrease time
	time_left -= 1
	
	var time_text = str(floor(time_left / 60)) + ":" + str(time_left % 60)
	
	$CountdownText.text = time_text
	
	# Restart second clock
	$CountdownText/CountdownTimer.start()
	


func _on_notifier_timer_timeout() -> void:
	$CheeseNotifier.hide()
