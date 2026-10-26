extends Area2D

@onready var fade_anim: AnimationPlayer = $"../BlackScreen/AnimationPlayer"
@onready var player: CharacterBody2D = $"../Path2D/PathFollow2D/Player"
@onready var black_screen: ColorRect = $"../BlackScreen"
@onready var switch_timer: Timer = $"../Timer"
@onready var path_follower: PathFollow2D = $"../Path2D/PathFollow2D"

var is_path_following = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	black_screen.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_path_following:
		path_follower.progress_ratio += 0.011
		
		if path_follower.progress_ratio >= 1:
			is_path_following = false

func _on_body_entered(body: Node2D) -> void:
	player.set_physics_process(false)
	black_screen.show()
	fade_anim.play("fade_in")
	switch_timer.start()
	is_path_following = true


func _on_body_exited(body: Node2D) -> void:
	print("exited")


func _on_timer_timeout() -> void:
	print("timer out")
	get_tree().call_deferred("change_scene_to_file", "res://area_1.tscn")
