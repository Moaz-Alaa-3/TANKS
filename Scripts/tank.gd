extends CharacterBody2D
@onready var bullet_spawn: Marker2D = $BulletSpawn
@onready var shoot_sound: AudioStreamPlayer2D = $shoot_sound

var recoil_vector: Vector2= Vector2.ZERO
var recoil_tween: Tween

@export var speed:float = 200.0
@export var rotation_speed: float = 2.5
@export_enum("red","blue") var player:String
@export var bullet_scene: PackedScene

func _physics_process(delta: float) -> void:
	var roation_direction:float = Input.get_axis("ui_left","ui_right")
	rotation += roation_direction * rotation_speed * delta
	
	var foward_direction = Vector2.LEFT.rotated(rotation)
	
	var move_input = Input.get_axis("ui_down","ui_up")
	
	velocity = foward_direction * move_input * speed + recoil_vector
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_accept"):
		shoot()

func shoot():
	var bullet = bullet_scene.instantiate()
	
	bullet.global_position = bullet_spawn.global_position
	bullet.global_rotation = bullet_spawn.global_rotation
	shoot_sound.play()
	
	if recoil_tween and recoil_tween.is_valid():
		recoil_tween.kill()
	
	recoil_tween = create_tween()
	
	var start_pos: Vector2 = global_position
	var push_back: Vector2 = global_position + (transform.x * 15.0)
	
	recoil_tween.tween_property(self,"global_position",push_back,0.05).set_trans(Tween.TRANS_QUAD)
	
	recoil_tween.tween_property(self,"global_position",start_pos,0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	get_tree().current_scene.add_child(bullet)
