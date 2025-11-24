#extends CharacterBody2D
#
#
#const SPEED = 150.0
#const JUMP_VELOCITY = -250.0
#
#
#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()

extends CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Constants
const SPEED = 120.0
const JUMP_VELOCITY = -300.0  # Negative for upward movement
#var velocity: Vector2 = Vector2.ZERO

# Get the gravity from the project settings to be consistent
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") 

# Movement vector
var direction: float = 0.0
func _physics_process(delta):
	# Apply Gravity
	if not is_on_floor():
		# velocity.y is the y-component of the built-in velocity vector
		velocity.y += get_gravity().y * delta
	
	# Handle Jump Input
	# Check if the player is on the floor AND the jump action is pressed
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Infinite jump	
	#if Input.is_action_just_pressed("ui_accept"):
		#velocity.y = JUMP_VELOCITY
		
	# Get input direction: -1, 0, 1
	direction = Input.get_axis("move_left", "move_right")
	
	#Flip the character/sprite
	if direction > 0:
		animated_sprite.flip_h = false
	if direction < 0:
		animated_sprite.flip_h = true
	
	# MY SOLUTION Turn character body depending on walking direction
	#if Input.is_action_just_pressed("move_left"):
		#animated_sprite.flip_h = true
	#if Input.is_action_just_pressed("move_right"):
		#animated_sprite.flip_h = false
		
	#Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	
	# Calculate horizontal velocity
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Built-in Godot function to move the body and resolve collisions
	move_and_slide()
