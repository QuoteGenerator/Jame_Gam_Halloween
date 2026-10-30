extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D

var level:int = 1
var speed:int = 300

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
	
	
func _on_pickup_area_area_entered(area: Area2D) -> void:
	if area.name == "pumpkin_pie":
		add_item("pumpkin_pie")
		area.queue_free()
	
	elif area.name == "pumpkin_soup":
		add_item("pumpkin_soup")
		area.queue_free()
	
	elif area.name == "pumpkin_spice_latte":
		add_item("pumpkin_spice_latte")
		area.queue_free()	
	
func add_item(item_name: String) -> void:
	for item in GameState.items:
		if item["Name"] == item_name:
			item["Amount"] += 1
			print(item["Name"], ": ", item["Amount"])
			return
