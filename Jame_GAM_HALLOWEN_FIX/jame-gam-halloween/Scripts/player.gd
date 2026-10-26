extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D

var level:int = 1
var speed:int = 100

var health:int = 100
var max_health:int = 100

var mana: int = 25
var max_mana:int = 100

var player_name:String = "Pumpkin"

func _ready() -> void:
	level = GameState.player_level
	
	health = GameState.player_health
	max_health = GameState.player_max_health
	
	mana = GameState.player_mana
	max_mana = GameState.player_max_mana
	
	
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


func on_mouse_entered() -> void:
	pass # Replace with function body.
