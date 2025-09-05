extends CharacterBody2D
# tree access
@onready var animated_sprite = $AnimatedSprite2D

# physics
@export var max_speed := 175.0
@export var acceleration := 2500.0
@export var gravity := 2000.0
@export var jump_speed := 400.0  # positive number; we subtract to go up

# initialistation
var last_direction := 0
var djump = true

func _physics_process(delta: float) -> void:
	# horizontal movement
	var direction := Input.get_axis("move_left", "move_right")
	
	# flip the sprite
	if direction != 0 and direction != last_direction:
		# Direction changed (non-zero), so play turn animation
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true

	last_direction = direction
	
	# animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
		
	# horizontal acceleration
	var target_x := direction * max_speed
	velocity.x = move_toward(velocity.x, target_x, acceleration * delta)

	# gravity + jumping
	if not is_on_floor():
		if Input.is_action_just_pressed("jump") and djump:
			velocity.y = -jump_speed
			djump = false
		velocity.y += gravity * delta
	else:
		djump = true
		if Input.is_action_just_pressed("jump"):
			velocity.y = -jump_speed

	move_and_slide()
