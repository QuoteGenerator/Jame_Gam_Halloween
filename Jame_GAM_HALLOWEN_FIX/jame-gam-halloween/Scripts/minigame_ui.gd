extends CanvasLayer

const BALL = preload("uid://chlatv77gfsbh")

@onready var instructions_1: Label = $Instructions1
@onready var instructions_2: Label = $Instructions2

@onready var dialogue_starter: Timer = $dialogue_starter
@onready var timer: Timer = $Timer
@onready var end_minigame_timer: Timer = $End_Minigame2

@onready var player: CharacterBody2D = $Player
@onready var mg_2_box: StaticBody2D = $MG2_Box

@onready var animationEnemyPlayer: AnimationPlayer = $tbc_AnimationEnemy
@onready var path_follower: PathFollow2D = $Path2D/PathFollow2D
@onready var player_hit: Area2D = $Path2D/PathFollow2D/PlayerHit
@onready var collision_shape_player: CollisionShape2D = $Path2D/PathFollow2D/PlayerHit/CollisionShape2D
@onready var color_rect: ColorRect = $Path2D/PathFollow2D/PlayerHit/ColorRect

@onready var collision1: CollisionShape2D = $field1/CollisionShape2D
@onready var collision2: CollisionShape2D = $field2/CollisionShape2D
@onready var collision3: CollisionShape2D = $field3/CollisionShape2D

@onready var field_1: Area2D = $field1
@onready var field_2: Area2D = $field2
@onready var field_3: Area2D = $field3

@onready var heart: Sprite2D = $Heart
@onready var heart_2: Sprite2D = $Heart2
@onready var heart_3: Sprite2D = $Heart3

@onready var fade_anim: AnimationPlayer = $BlackScreen/AnimationPlayer
@onready var black_screen: ColorRect = $BlackScreen
@onready var textbox: DialogueBox_End1 = $Textbox

var text_queued = false
var dialogue_end = false

var play_fadein = false
var play_fadeout = false

var field1_cleared = false
var field2_cleared = false
var field3_cleared = false

var player_in_field1 = false
var player_in_field2 = false
var player_in_field3 = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textbox.dialogue_end_finished.connect(dialogue2_finished)
	
	black_screen.show()
	process_mode = Node.PROCESS_MODE_ALWAYS
	animationEnemyPlayer.play("tbc_witch_idle_animation")
	hide()
	
	collision2.set_deferred("disabled", true)
	collision3.set_deferred("disabled", true)
	
	player.set_physics_process(false)
	player.hide()
	mg_2_box.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _process(delta: float) -> void:
	print("prunning")
	print(GameState.start_minigame)
	if GameState.start_minigame:
		print("starting minigame")
		show()
		
		if not text_queued:
			dialogue_starter.start()
			Music.stop()
			text_queued = true
			instructions_1.show()
			
		path_follower.progress_ratio += 0.007
		
		if (Input.is_action_just_pressed("Interact") and dialogue_end):
			if not field1_cleared:
				if player_in_field1:
					print("hit ONE")
					field1_cleared = true
					collision1.set_deferred("disabled", true)
					field_1.hide()
					
					field_2.show()
					collision2.set_deferred("disabled", false)
			
				else:
					lose_heart()
				
			elif not field2_cleared:
				if player_in_field2:
					print("hit TWO")
					field2_cleared = true
					collision2.set_deferred("disabled", true)
					field_2.hide()
					
					field_3.show()
					collision3.set_deferred("disabled", false)
			
				else:
					lose_heart()
			
			elif not field3_cleared:
				if player_in_field3:
					print("hit THREE")
					field3_cleared = true
					collision2.set_deferred("disabled", true)
					field_3.hide()
					color_rect.hide()
					print("YOU BEAT MINIGAME ONE!")
					instructions_1.hide()
					mg_2_box.show()
					instructions_2.show()
					player.show()
					player.set_physics_process(true)
					timer.start()
					end_minigame_timer.start()
			
				else:
					lose_heart()

func dialogue2_finished():
	
	if not play_fadeout:
		play_fadeout = true
		fade_anim.play("fade_out")
		await fade_anim.animation_finished
		Music.play("fighting_area")
		dialogue_end = true
		
	else:
		print("hide minigame")
		hide()
		print("Minigame visible: ", visible)
		get_tree().call_deferred("change_scene_to_file", "res://outro.tscn")
		GameState.start_second_tbc_phase = true
		print("GameState value: ", GameState.start_second_tbc_phase)
		
		

func lose_heart():
	if heart_3.visible:
		heart_3.hide()
	elif heart_2.visible:
		heart_2.hide()
	elif heart.visible:
		heart.hide()
		GameState.player_health = 0
		print("you lose!")
		
func _on_dialogue_starter_timeout() -> void:
	textbox.queue_text("WITCH: Let's see if you can survive this!")
	
func dialogue3_finished():
	hide()
	
func _on_timer_timeout() -> void:
	var ballClone : Sprite2D = BALL.instantiate()
	add_child(ballClone)
	ballClone.position = Vector2(get_viewport().get_visible_rect().size.x - 325, randf_range(900, 1160))
	print("cloning")

func _on_end_minigame_2_timeout() -> void:
	print("minigame 2 over!")
	remove_all_balls()
	player.set_physics_process(false)
	fade_anim.play("fade_in")
	
	await fade_anim.animation_finished
	
	textbox.queue_text("WITCH: ...")

func remove_all_balls():
	timer.stop()
	get_tree().call_group("ball_clones", "queue_free")

func _on_field_1_area_entered(area: Area2D) -> void:
	print("entered")
	player_in_field1 = true
	
func _on_field_1_area_exited(area: Area2D) -> void:
	print("exited")
	player_in_field1 = false


func _on_field_2_area_entered(area: Area2D) -> void:
	player_in_field2 = true


func _on_field_2_area_exited(area: Area2D) -> void:
	player_in_field2 = false


func _on_field_3_area_entered(area: Area2D) -> void:
	player_in_field3 = true


func _on_field_3_area_exited(area: Area2D) -> void:
	player_in_field3 = false
