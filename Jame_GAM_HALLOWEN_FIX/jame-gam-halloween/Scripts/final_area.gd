extends Node2D

@onready var textbox: DialogueBox_End1 = $Textbox
@onready var timer: Timer = $Timer

@onready var player: CharacterBody2D = $PlayerPath/PathFollow2D/Player
@onready var path_follower: PathFollow2D = $PlayerPath/PathFollow2D
@onready var black_screen: ColorRect = $BlackScreen
@onready var fade_anim: AnimationPlayer = $BlackScreen/AnimationPlayer

@onready var witch: CharacterBody2D = $witch
@onready var path_follower_witch: PathFollow2D = $Path2D/PathFollow2D
@onready var remote_transform_witch: RemoteTransform2D = $Path2D/PathFollow2D/RemoteTransform2D
@onready var combat_ui: CanvasLayer = $CombatUI

var is_path_following = false
var witch_chase = false
var dialogue_started = false
var queue_outro = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.final_area_reached = true
	Music.play("final_area")
	textbox.dialogue_end_finished.connect(_on_dialogue_end_finished)
	is_path_following = true
	
	black_screen.show()
	fade_anim.play("fade_out")
	await fade_anim.animation_finished
	black_screen.hide()
	
	
	witch_chase = false
	witch.chasing = false
	witch.speed = 0.0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#print("final area ps")
	
	print("Final Area BlackScreen: ", black_screen.visible)
	
	if is_path_following:
		player.set_physics_process(false)
		path_follower.progress_ratio += 0.007
	
	if path_follower.progress_ratio == 1 and not dialogue_started:
		dialogue_started = true
		textbox.queue_text("WITCH: I'm surprised you've made it so far!")
		textbox.queue_text("WITCH: You are an impressive little pumpkin after all...")
		textbox.queue_text("WITCH: Though you won't live to tell the tale after I'm done with you!")
		textbox.queue_text("WITCH: NYEHEHEHEHE")
		
	if witch_chase:
		witch.chasing = true
		
#	if combat_ui.combat_over and queue_outro:
#		queue_outro = false
#		black_screen.show()
#		fade_anim.play("fade_in")
#		timer.start()

func _on_dialogue_end_finished():
	witch.speed = 110.0
	witch.chasing = true


func _on_timer_timeout() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://outro.tscn")
