extends CharacterBody2D
@export var speed:float = 200.0
@export var rotation_speed: float = 2.5
@export_enum("red","blue") var player:String

func _physics_process(delta: float) -> void:
	var roation_direction:float = Input.get_axis("ui_left","ui_right")
	rotation += roation_direction * rotation_speed * delta
	
	var foward_direction = Vector2.LEFT.rotated(rotation)
	print(foward_direction)
	
	var move_input = Input.get_axis("ui_down","ui_up")
	velocity = foward_direction * move_input * speed
	move_and_slide()
