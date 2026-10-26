extends CharacterBody2D

var speed: float = 110.0
var player: Node2D
var chasing: bool = false
var in_combat: bool = false
@export var health: int = 100
@export var max_health: int = 100
@export var mana: int = 15
@export var max_mana: int = 15
@export var enemy_name: String = "ENEMY"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var detection_area: Area2D = $DetectionArea

func _ready() -> void:
	detection_area.body_entered.connect(_on_body_entered)
	detection_area.body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		chasing = true


func _on_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
		chasing = false


func _physics_process(delta: float) -> void:
	var direction := Vector2.ZERO

	if chasing and player:
		direction = global_position.direction_to(player.global_position)
		rotation = global_position.angle_to_point(player.global_position)

	velocity = direction * speed
	
	if chasing:
		animation_player.play("move_animation")
	else:
		animation_player.play("idle_animation")

	
	move_and_slide()
	
	if chasing and not in_combat:
		var collision := get_last_slide_collision()

		if collision:
			var body = collision.get_collider()

			if body is Node2D and body.is_in_group("player"):
				start_combat(body)


func start_combat(_body: Node2D) -> void:
	if in_combat:
		return

	in_combat = true
	chasing = false
	velocity = Vector2.ZERO

	var combat_ui = get_tree().get_first_node_in_group("combat_ui")

	if combat_ui:
		combat_ui.start_combat(self, _body)
