extends Area2D

@onready var timer: Timer = $Timer

func _ready() -> void:
	Engine.time_scale = 1.0

func _on_body_entered(body: Node2D) -> void:
	# slowdown time for dramatic effect
	Engine.time_scale = 0.5
	var collision_shape = body.get_node_or_null("CollisionShape2D")
	if collision_shape:
		collision_shape.queue_free()
	if timer.is_stopped():
		timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
