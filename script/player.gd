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

const SPEED = 120.0
const JUMP_VELOCITY = -300.0

var direction: float = 0.0

func _ready() -> void:
	floor_snap_length = 8.0
	floor_constant_speed = true

func _physics_process(delta):
	# apply gravity if not on ground
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	
	# jump only if on floor
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	direction = Input.get_axis("move_left", "move_right")
	
	# flip sprite depend on direction
	if direction > 0:
		animated_sprite.flip_h = false
	if direction < 0:
		animated_sprite.flip_h = true
	
	# MY SOLUTION Turn character body depending on walking direction
	#if Input.is_action_just_pressed("move_left"):
		#animated_sprite.flip_h = true
	#if Input.is_action_just_pressed("move_right"):
		#animated_sprite.flip_h = false
		
	# animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
