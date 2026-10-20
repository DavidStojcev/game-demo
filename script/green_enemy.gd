extends CharacterBody2D

const SPEED = 60.0

var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_down: RayCast2D = $RayCastDown
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	floor_snap_length = 8.0
	floor_constant_speed = true

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	# raycast infront so it dont fall off
	if ray_cast_down:
		ray_cast_down.position.x = direction * 8.0
		ray_cast_down.target_position = Vector2(0, 18.0)

	var is_at_ledge := false
	if is_on_floor() and ray_cast_down:
		ray_cast_down.force_raycast_update()
		is_at_ledge = not ray_cast_down.is_colliding()

	# turn around if hitting wall or egde
	if direction > 0 and (ray_cast_right.is_colliding() or is_on_wall() or is_at_ledge):
		direction = -1
		animated_sprite.flip_h = true
	elif direction < 0 and (ray_cast_left.is_colliding() or is_on_wall() or is_at_ledge):
		direction = 1
		animated_sprite.flip_h = false

	velocity.x = direction * SPEED
	move_and_slide()
