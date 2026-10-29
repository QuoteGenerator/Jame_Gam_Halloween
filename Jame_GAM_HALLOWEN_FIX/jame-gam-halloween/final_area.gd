extends Node2D

@onready var textbox: DialogueBox_End1 = $Textbox

@onready var player: CharacterBody2D = $PlayerPath/PathFollow2D/Player
@onready var path_follower: PathFollow2D = $PlayerPath/PathFollow2D
@onready var black_screen: ColorRect = $BlackScreen
@onready var fade_anim: AnimationPlayer = $BlackScreen/AnimationPlayer

@onready var witch: CharacterBody2D = $witch
@onready var path_follower_witch: PathFollow2D = $Path2D/PathFollow2D
@onready var remote_transform_witch: RemoteTransform2D = $Path2D/PathFollow2D/RemoteTransform2D

var is_path_following = false
var witch_chase = false
var dialogue_started = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textbox.dialogue_end_finished.connect(_on_dialogue_end_finished)
	is_path_following = true
	fade_anim.play("fade_out")
	black_screen.show()
	
	witch_chase = false
	witch.chasing = false
	witch.speed = 0.0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
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
		
	if is_instance_valid(witch) and witch.health <= 0:
		print("witch dead!")

func _on_dialogue_end_finished():
	witch.speed = 110.0
	witch.chasing = true
