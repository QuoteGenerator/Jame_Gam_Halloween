extends CanvasLayer


var current_enemy: CharacterBody2D
var current_player: CharacterBody2D
@onready var animationEnemyPlayer: AnimationPlayer = $Panel/tbc_AnimationEnemy

@onready var enemyNameLabel: Label = $Panel/Control/EnemyName
@onready var enemyStatsLabel: Label = $Panel/Control/EnemyStats

@onready var playerNameLabel: Label = $Panel/Control/PlayerName
@onready var playerStatsLabel: Label = $Panel/Control/PlayerStats

@onready var turnLabel: Label = $Panel/Control/TurnLabel

@onready var pumpkin_pie_amount_label: Label = $Panel/Control/pumpkin_pie_button/pumpkin_pie_amount
@onready var pumpkin_soup_amount_label: Label = $Panel/Control/pumpkin_soup_button/pumpkin_soup_amount
@onready var pumpkin_spice_latte_amount_label: Label = $Panel/Control/pumpkin_spice_latte_button/pumpkin_spice_latte_amount

@onready var sparkle: AnimatedSprite2D = $Panel/Wand/Sparkle
@onready var path_follower: PathFollow2D = $Panel/WandPath1/PathFollow2D
@onready var remote_transform: RemoteTransform2D = $Panel/WandPath1/PathFollow2D/RemoteTransform2D
@onready var wand: AnimatedSprite2D = $Panel/Wand/Wand

var wand_path_following:bool = false

var playersTurn:bool = true
var enemysTurn:bool = false

var combat_over:bool = false

func _ready() -> void:
	visible = false
	turnLabel.text = "* YOUR TURN *"

func _physics_process(delta: float) -> void:
	if wand_path_following:
		path_follower.progress_ratio += 0.050
	
	if path_follower.progress_ratio >= 1 and wand_path_following:
		remote_transform.remote_path = NodePath("")
		wand_path_following = false

func start_combat(enemy: CharacterBody2D, player: CharacterBody2D) -> void:
	playersTurn = true
	
	enemysTurn = false
	current_enemy = enemy
	current_player = player
	
	showItemAmount()
	
	visible = true

	get_tree().paused = true
	
	if(enemy.is_in_group("skeleton")):
		SkeletonEnemyBattle()
	
	if(enemy.is_in_group("ghost")):
		GhostEnemyBattle()
	
	if(enemy.is_in_group("zombie")):
		ZombieEnemyBattle()
		
	if(enemy.is_in_group("witch")):
		WitchEnemyBattle()
		
	if player != null:
		update_player_stats()
		

func update_player_stats():
	playerNameLabel.text = current_player.player_name
	playerStatsLabel.text = \
	"HP: " + str(current_player.health) + "/" + str(current_player.max_health) + "    "\
	+ "MANA: " + str(current_player.mana) + "/" + str(current_player.max_mana)

func SkeletonEnemyBattle():
	animationEnemyPlayer.play("tbc_skeleton_idle_animation")
	enemyNameLabel.text = current_enemy.enemy_name
	update_enemy_stats()


func GhostEnemyBattle():
	animationEnemyPlayer.play("tbc_ghost_idle_animation")
	enemyNameLabel.text = current_enemy.enemy_name
	update_enemy_stats()
	
func ZombieEnemyBattle():
	animationEnemyPlayer.play("tbc_zombie_idle_animation")
	enemyNameLabel.text = current_enemy.enemy_name
	update_enemy_stats()
	
func WitchEnemyBattle():
	animationEnemyPlayer.play("tbc_witch_idle_animation")
	enemyNameLabel.text = current_enemy.enemy_name
	update_enemy_stats()	
	
func update_enemy_stats():
	if current_enemy.health <= 0:
		end_combat()
		return
		
	enemyStatsLabel.text = \
	"HP: " + str(current_enemy.health) + "/" + str(current_enemy.max_health) + "    "\
	+ "MANA: " + str(current_enemy.mana) + "/" + str(current_enemy.max_mana)
	
	Enemy_Attack()
	
	
func end_combat():
	current_enemy.queue_free()

	current_enemy = null
	visible = false
	get_tree().paused = false
	combat_over = true
	
func Player_Basic_Attack():
	if playersTurn:
		playersTurn = false
		turnLabel.text = "* YOUR TURN *"
		sparkle.play("sparkle")
		wand_path_following = true
		path_follower.progress = 0.0
		remote_transform.remote_path = wand.get_path()
		
		
func _on_sparkle_animation_finished() -> void:
	var scene_name_enemy = current_enemy.scene_file_path.get_file().get_basename()
	animationEnemyPlayer.play("tbc_"+scene_name_enemy+"_getHit_animation")
		
	await animationEnemyPlayer.animation_finished
	
	current_enemy.health -= 5
	playersTurn = false
	enemysTurn = true
	update_enemy_stats()
	
func Enemy_Attack():
	if enemysTurn:
		turnLabel.modulate = Color(255,0,0)
		turnLabel.text = "*" + current_enemy.enemy_name + "*"
		await get_tree().create_timer(2.0, true).timeout
		current_player.health -= 5
		GameState.player_health -= 5
		playersTurn = true
		enemysTurn = false
		update_player_stats()
		turnLabel.modulate = Color(255,255,255)
		turnLabel.text = "* YOUR TURN *"
		

func showItemAmount():
	
	var pumpkin_pie_amount = GameState.items[0].Amount
	var pumpkin_soup_amount = GameState.items[1].Amount
	var pumpkin_spice_latte_amount = GameState.items[2].Amount
	
	
	
	pumpkin_pie_amount_label.text = str(pumpkin_pie_amount) + "x"
	pumpkin_soup_amount_label.text = str(pumpkin_soup_amount) + "x"
	pumpkin_spice_latte_amount_label.text = str(pumpkin_spice_latte_amount) + "x"


func play_enemy_idle_animation():
	if(current_enemy != null):
		var scene_name_enemy = current_enemy.scene_file_path.get_file().get_basename()
		animationEnemyPlayer.play("tbc_"+ scene_name_enemy +"_idle_animation")
