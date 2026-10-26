extends CanvasLayer


var current_enemy: CharacterBody2D
var current_player: CharacterBody2D
@onready var animationPlayer: AnimationPlayer = $Panel/tbc_AnimationEnemy

@onready var enemyNameLabel: Label = $Panel/Control/EnemyName
@onready var enemyStatsLabel: Label = $Panel/Control/EnemyStats

@onready var playerNameLabel: Label = $Panel/Control/PlayerName
@onready var playerStatsLabel: Label = $Panel/Control/PlayerStats

func _ready() -> void:
	visible = false


func start_combat(enemy: CharacterBody2D, player: CharacterBody2D) -> void:
	current_enemy = enemy
	current_player = player

	visible = true

	get_tree().paused = true
	
	if(enemy.is_in_group("skeleton")):
		SkeletonEnemyBattle()
	
	if(enemy.is_in_group("ghost")):
		GhostEnemyBattle()
		
	if player != null:
		update_player_stats()
		

func update_player_stats():
	playerNameLabel.text = current_player.player_name
	playerStatsLabel.text = \
	"HP: " + str(current_player.health) + "/" + str(current_player.max_health) + "    "\
	+ "MANA: " + str(current_player.mana) + "/" + str(current_player.max_mana)

func SkeletonEnemyBattle():
	animationPlayer.play("tbc_skeleton_idle_animation")
	enemyNameLabel.text = current_enemy.enemy_name
	update_enemy_stats()


func GhostEnemyBattle():
	animationPlayer.play("tbc_ghost_idle_animation")
	enemyNameLabel.text = current_enemy.enemy_name
	update_enemy_stats()
	
func update_enemy_stats():
	if current_enemy.health <= 0:
		end_combat()
		return
		
	enemyStatsLabel.text = \
	"HP: " + str(current_enemy.health) + "/" + str(current_enemy.max_health) + "    "\
	+ "MANA: " + str(current_enemy.mana) + "/" + str(current_enemy.max_mana)
	
func end_combat():
	current_enemy.queue_free()

	current_enemy = null
	visible = false
	get_tree().paused = false
