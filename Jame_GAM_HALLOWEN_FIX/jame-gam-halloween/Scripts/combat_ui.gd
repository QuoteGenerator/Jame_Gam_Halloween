extends CanvasLayer


var current_enemy: CharacterBody2D
@onready var animationPlayer: AnimationPlayer = $Panel/tbc_AnimationEnemy

func _ready() -> void:
	visible = false


func start_combat(enemy: CharacterBody2D) -> void:
	current_enemy = enemy

	visible = true

	get_tree().paused = true
	
	if(enemy.name == "SkeletonEnemy"):
		SkeletonEnemyBattle()
	
	if(enemy.name == "GhostEnemy"):
		GhostEnemyBattle()
		

func SkeletonEnemyBattle():
	animationPlayer.play("tbc_skeleton_idle_animation")
	
	
func GhostEnemyBattle():
	animationPlayer.play("tbc_ghost_idle_animation")
