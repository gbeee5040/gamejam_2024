extends CharacterBody2D

const speed = 125.0
const jumpVelocity = -250.0
const accel = 50
const friction = 50
const gravity = 900.0
const jumpBufferTime = 15
const coyoteTime = 15
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var jumpBufferCounter = 0
var coyoteCounter = 0

func _physics_process(delta: float) -> void:
	var inputDir: Vector2 = get_input_direction()
	
	if is_on_floor():
		coyoteCounter = coyoteTime
		if inputDir.x == 0.0:
			#print("idle")
			animated_sprite.play("idle")
		else:
			
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	# Add the gravity.
	if not is_on_floor():
		if coyoteCounter > 0:
			coyoteCounter -= 1
		velocity.y += gravity * delta
	
	if inputDir.x>0.0:
		#print("right")
		animated_sprite.flip_h = false
	elif inputDir.x<0.0:
		#print("left")
		animated_sprite.flip_h = true
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jumpBufferCounter = jumpBufferTime
		
	if jumpBufferCounter > 0:
		jumpBufferCounter -= 1
		
	if jumpBufferCounter > 0 and (is_on_floor() or coyoteCounter > 0):
		velocity.y = jumpVelocity
		jumpBufferCounter = 0
		coyoteCounter = 0 

	# Move the character horizontally
	if inputDir != Vector2.ZERO:
		accelerate(inputDir, delta)
	else:
		if is_on_floor():
			add_friction(delta)

	# Restart game if needed
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

	playerMovement()

func get_input_direction() -> Vector2:
	var inputDir = Vector2.ZERO
	inputDir.x = Input.get_axis("move_left", "move_right")
	return inputDir.normalized()

func accelerate(direction: Vector2, delta: float) -> void:
	velocity.x = lerp(velocity.x, speed * direction.x, accel * delta)
		
func add_friction(delta: float) -> void:
	velocity.x = lerp(velocity.x, float(0), friction * delta)

func playerMovement() -> void:
	move_and_slide()
	
func get_angle(dir: Vector2) -> int:
	match dir:
		Vector2(1, 0):
			return 0
		Vector2(0 ,1):
			return 90
		Vector2(1 ,1):
			return 45
	return -1 # Vector2(0, 0)
