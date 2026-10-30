extends Node2D

@onready var timer: Timer = $Timer
@onready var fade_anim: AnimationPlayer = $BlackScreen/AnimationPlayer
@onready var black_screen: ColorRect = $BlackScreen
@onready var hardBtn: Button = $Control/HardBtn
@onready var normalBtn: Button = $Control/NormalBtn
@onready var playBtn: Button = $Control/PlayBtn
@onready var click: AudioStreamPlayer = $Click

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Music.play("menu")
	black_screen.hide()



func _on_play_btn_pressed() -> void:
	click.play()
	hardBtn.visible = true
	normalBtn.visible = true
	playBtn.visible = false

func _on_hard_btn_pressed() -> void:
	click.play()
	GameState.difficulty = "hard"
	black_screen.show()
	fade_anim.play("fade_in")
	timer.start()

func _on_normal_btn_pressed() -> void:
	click.play()
	GameState.difficulty = "normal"
	black_screen.show()
	fade_anim.play("fade_in")
	timer.start()

func _on_timer_timeout() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://main.tscn")
