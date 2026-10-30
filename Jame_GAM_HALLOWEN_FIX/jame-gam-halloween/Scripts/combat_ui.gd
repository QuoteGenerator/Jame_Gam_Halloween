extends CanvasLayer


var current_enemy: CharacterBody2D
var current_player: CharacterBody2D
@onready var animationEnemyPlayer: AnimationPlayer = $Panel/tbc_AnimationEnemy
@onready var animationPlayerPlayer: AnimationPlayer = $Panel/tbc_AnimationPlayer

@onready var enemyNameLabel: Label = $Panel/Control/EnemyName
@onready var enemyStatsLabel: Label = $Panel/Control/EnemyStats

@onready var playerNameLabel: Label = $Panel/Control/PlayerName
@onready var playerStatsLabel: Label = $Panel/Control/PlayerStats
@onready var playerLvlLabel: Label = $Panel/Control/PlayerLvl

@onready var turnLabel: Label = $Panel/Control/TurnLabel

@onready var pumpkin_pie_amount_label: Label = $Panel/Control/pumpkin_pie_button/pumpkin_pie_amount
@onready var pumpkin_soup_amount_label: Label = $Panel/Control/pumpkin_soup_button/pumpkin_soup_amount
@onready var pumpkin_spice_latte_amount_label: Label = $Panel/Control/pumpkin_spice_latte_button/pumpkin_spice_latte_amount

@onready var sparkle: AnimatedSprite2D = $Panel/Wand/Sparkle
@onready var path_follower: PathFollow2D = $Panel/WandPath1/PathFollow2D
@onready var remote_transform: RemoteTransform2D = $Panel/WandPath1/PathFollow2D/RemoteTransform2D
@onready var wand: AnimatedSprite2D = $Panel/Wand/Wand

@onready var black_screen: ColorRect = $BlackScreen
@onready var fade_anim: AnimationPlayer = $BlackScreen/AnimationPlayer

var final_boss:bool = false

var basic_attack_used:bool = false
var spell2_used:bool = false
var spell3_used:bool = false
var spell4_used:bool = false

var wand_path_following:bool = false

var playersTurn:bool = true
var enemysTurn:bool = false

var combat_over:bool = false

var ZweitePhase = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	black_screen.hide()
	visible = false
	turnLabel.text = "* YOUR TURN *"
	

func _physics_process(delta: float) -> void:
	#print("physics process running ")
	if wand_path_following:
		path_follower.progress_ratio += 0.050
	
	if path_follower.progress_ratio >= 1 and wand_path_following:
		remote_transform.remote_path = NodePath("")
		wand_path_following = false
	
	if GameState.start_second_tbc_phase and not ZweitePhase:
		ZweitePhase = true
		show()
		black_screen.show()
		print("start 2nd phase")
		print(GameState.start_second_tbc_phase)
		fade_anim.play("fade_out")
		
		await fade_anim.animation_finished
		black_screen.hide()
		
		print("Combat BlackScreen visible: ", black_screen.visible)
		print("Combat UI visible: ", visible)
		

func start_combat(enemy: CharacterBody2D, player: CharacterBody2D) -> void:
	Music.stop()
	Music.play("fighting_area")
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
		print("witchy")
		final_boss = true
		WitchEnemyBattle()
		
	if player != null:
		update_player_stats()
		

func update_player_stats():
	playerNameLabel.text = current_player.player_name
	playerStatsLabel.text = \
	"HP: " + str(current_player.health) + "/" + str(current_player.max_health) + "    "\
	+ "MANA: " + str(current_player.mana) + "/" + str(current_player.max_mana)
	playerLvlLabel.text = "LVL: " + str(GameState.player_level)


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
	final_boss = true
	print("boss: ", final_boss)
	update_enemy_stats()	
	
func update_enemy_stats():
		
	if current_enemy.health <= 0 and final_boss:
	#final_boss:
		print("queue minigame!!!")
		black_screen.show()
		GameState.start_minigame = true
		get_tree().paused = false
		#hide()
	if current_enemy.health <= 0:
		GameState.player_level += 1
		end_combat()
		return
		
	enemyStatsLabel.text = \
	"HP: " + str(current_enemy.health) + "/" + str(current_enemy.max_health) + "\n"\
	+ "Hit Chance: " + str(current_enemy.hit_chance * 100) + "%"
	
	Enemy_Attack()
	
	
func end_combat():
	current_enemy.queue_free()

	current_enemy = null
	visible = false
	get_tree().paused = false
	combat_over = true
	Music.stop()
	Music.play("explore_areas")
	
func Player_Basic_Attack():
	if playersTurn:
		playersTurn = false
		turnLabel.text = "* YOUR TURN *"
		sparkle.play("sparkle")
		wand_path_following = true
		path_follower.progress = 0.0
		remote_transform.remote_path = wand.get_path()
		basic_attack_used = true
		update_player_stats()
		
func Player_2nd_Spell():
	if playersTurn:
		if (GameState.fireball_picked and current_player.mana >= 10 or GameState.meteor_picked and current_player.mana >= 15):			
			playersTurn = false
			turnLabel.text = "* YOUR TURN *"
			sparkle.play("sparkle")
			wand_path_following = true
			path_follower.progress = 0.0
			remote_transform.remote_path = wand.get_path()
			spell2_used = true
	
func Player_3rd_Spell():
	if playersTurn:
		if (GameState.gust_picked and current_player.mana >= 10 or GameState.tornado_picked and current_player.mana >= 15):
			playersTurn = false
			turnLabel.text = "* YOUR TURN *"
			sparkle.play("sparkle")
			wand_path_following = true
			path_follower.progress = 0.0
			remote_transform.remote_path = wand.get_path()
			spell3_used = true

func Player_4th_Spell():
	if playersTurn:
		if (GameState.rockthrow_picked and current_player.mana >= 10 or GameState.brickthrow_picked and current_player.mana >= 15):
			playersTurn = false
			turnLabel.text = "* YOUR TURN *"
			sparkle.play("sparkle")
			wand_path_following = true
			path_follower.progress = 0.0
			remote_transform.remote_path = wand.get_path()
			spell4_used = true
		
func _on_sparkle_animation_finished() -> void:
	var scene_name_enemy = current_enemy.scene_file_path.get_file().get_basename()
	animationEnemyPlayer.play("tbc_"+scene_name_enemy+"_getHit_animation")
		
	await animationEnemyPlayer.animation_finished
	
	if basic_attack_used:
		current_enemy.health -= 5 * current_player.damage_multiplier
		current_player.mana += 5
		GameState.player_mana += 5
		if current_player.mana > current_player.max_mana:
			current_player.mana = current_player.max_mana
			GameState.player_mana = GameState.player_max_mana
		basic_attack_used = false
		
		
	elif spell2_used and GameState.fireball_picked and current_player.mana >= 10:
		current_player.mana -= 10
		GameState.player_mana -= 10
		if(randf_range(0,1) < 0.7):		
			if current_enemy.is_in_group("zombie"):
				current_enemy.health -= 11 * current_player.damage_multiplier
			current_enemy.health -= 8 * current_player.damage_multiplier
		spell2_used = false
	
	elif spell2_used and GameState.meteor_picked and current_player.mana >= 15:
		if(randf_range(0,1) <= 0.7):
			if current_enemy.is_in_group("zombie"):
				current_enemy.health -= 15 * current_player.damage_multiplier
			current_enemy.health -= 12 * current_player.damage_multiplier
		current_player.mana -= 15
		GameState.player_mana -= 15
		spell2_used = false
		
	elif spell3_used and GameState.gust_picked and current_player.mana >= 10:
		if(randf_range(0,1) <= 0.7):
			if current_enemy.is_in_group("ghost"):
				current_enemy.health -= 11 * current_player.damage_multiplier
			current_enemy.health -= 8 * current_player.damage_multiplier
		current_player.mana -= 10
		GameState.player_mana -= 10
		spell3_used = false
		
	elif spell3_used and GameState.tornado_picked and current_player.mana >= 15:
		if(randf_range(0,1) < 0.45):
			if current_enemy.is_in_group("ghost"):
				current_enemy.health -= 15 * current_player.damage_multiplier
			current_enemy.health -= 12 * current_player.damage_multiplier
		current_player.mana -= 15
		GameState.player_mana -= 15
		spell3_used = false
		
	elif spell4_used and GameState.rockthrow_picked and current_player.mana >= 10:
		if(randf_range(0,1) <= 0.7):
			if current_enemy.is_in_group("skeleton"):
				current_enemy.health -= 11 * current_player.damage_multiplier
			current_enemy.health -= 8 * current_player.damage_multiplier
		current_player.mana -= 10
		GameState.player_mana -= 10
		spell4_used = false
		
	elif spell4_used and GameState.brickthrow_picked and current_player.mana >= 10:
		if(randf_range(0,1) <= 0.45):
			if current_enemy.is_in_group("skeleton"):
				current_enemy.health -= 15 * current_player.damage_multiplier
			current_enemy.health -= 12 * current_player.damage_multiplier
		current_player.mana -= 15
		GameState.player_mana -= 15
		spell4_used = false
		
		
		
	playersTurn = false
	enemysTurn = true
	update_player_stats()	
	update_enemy_stats()
	current_player.damage_multiplier = 1.0
	GameState.damage_multiplier = current_player.damage_multiplier
	
	
func Enemy_Attack():
	if enemysTurn:
		turnLabel.modulate = Color(255,0,0)
		turnLabel.text = "*" + current_enemy.enemy_name + "*"
		await get_tree().create_timer(2.0, true).timeout
		
		var scene_name_player = current_player.scene_file_path.get_file().get_basename()
		animationEnemyPlayer.play("tbc_"+scene_name_player+"_getHit_animation")
		
		await animationEnemyPlayer.animation_finished
		
		if(randf_range(0,1) < current_enemy.hit_chance):	
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

func useItem(itemName):
	for item in GameState.items:
		if item["Name"] == itemName and item["Amount"] > 0:

			match itemName:
				"pumpkin_pie":
					if current_player.health == current_player.max_health:
						return
					current_player.health = min(5+current_player.health,current_player.max_health)
					GameState.player_health = current_player.health
				"pumpkin_soup":
					if current_player.mana == current_player.max_mana:
						return
					current_player.mana = min(5+current_player.mana,current_player.max_mana)
					GameState.player_mana = current_player.mana
				"pumpkin_spice_latte":
					current_player.damage_multiplier += 0.5
					GameState.damage_multiplier += 0.5

			item["Amount"] -= 1
			update_player_stats()
			showItemAmount()
			return
		
		

func play_enemy_idle_animation():
	if(current_enemy != null):
		var scene_name_enemy = current_enemy.scene_file_path.get_file().get_basename()
		animationEnemyPlayer.play("tbc_"+ scene_name_enemy +"_idle_animation")

func play_player_idle_animation():
	if(current_player != null):
		var scene_name_player = current_player.scene_file_path.get_file().get_basename()
		animationPlayerPlayer.play("tbc_"+ scene_name_player +"_idle_animation")
