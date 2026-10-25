extends CanvasLayer


var current_enemy: CharacterBody2D


func _ready() -> void:
	visible = false


func start_combat(enemy: CharacterBody2D) -> void:
	current_enemy = enemy

	visible = true

	get_tree().paused = true
