extends CharacterBody2D


const SPEED = 200


func _physics_process(delta: float) -> void:
	# Add the gravity.
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

	velocity = direction * SPEED
	

	move_and_slide()
