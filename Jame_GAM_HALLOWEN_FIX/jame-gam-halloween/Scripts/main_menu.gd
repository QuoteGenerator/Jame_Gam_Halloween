extends Node2D

@onready var timer: Timer = $Timer
@onready var fade_anim: AnimationPlayer = $BlackScreen/AnimationPlayer
@onready var black_screen: ColorRect = $BlackScreen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	black_screen.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_btn_pressed() -> void:
	black_screen.show()
	fade_anim.play("fade_in")
	timer.start()


func _on_timer_timeout() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://main.tscn")
