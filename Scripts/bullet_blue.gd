extends Area2D

@export var speed: float = 500.0

func _process(delta: float) -> void:
	position += -transform.y *  speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
