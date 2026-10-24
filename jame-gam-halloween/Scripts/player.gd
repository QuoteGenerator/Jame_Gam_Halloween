extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D

var speed:int = 100

func _physics_process(delta: float) -> void:
	
	sprite.rotation = global_position.angle_to_point(get_global_mouse_position())
	
	var direction := Vector2.ZERO

	if Input.is_key_pressed(KEY_A):
		direction.x -= 1
	if Input.is_key_pressed(KEY_D):
		direction.x += 1
	if Input.is_key_pressed(KEY_W):
		direction.y -= 1
	if Input.is_key_pressed(KEY_S):
		direction.y += 1

	direction = direction.normalized()

	velocity = direction * speed
	move_and_slide()
