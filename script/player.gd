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

# Constants
const SPEED = 140.0
const JUMP_VELOCITY = -250.0  # Negative for upward movement
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
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get horizontal movement input
	direction = Input.get_axis("ui_left", "ui_right")
	
	# Calculate horizontal velocity
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Built-in Godot function to move the body and resolve collisions
	move_and_slide()
