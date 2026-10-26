extends Area2D

@onready var player: CharacterBody2D = $"../Player"
@onready var black_screen: ColorRect = $"../BlackScreen"
@onready var fade_anim: AnimationPlayer = $"../BlackScreen/AnimationPlayer"
@onready var switch_timer: Timer = $"../Timer"
@onready var path_follower: PathFollow2D = $"../Path2D2/PathFollow2D"
@onready var remote_transform: RemoteTransform2D = $"../Path2D2/PathFollow2D/RemoteTransform2D"

var is_path_following = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_path_following:
		remote_transform.remote_path = remote_transform.get_path_to(player)
		path_follower.progress_ratio += 0.011
		player.set_physics_process(false)
	
	if path_follower.progress_ratio >= 1:
		is_path_following = false
		


func _on_body_entered(body: Node2D) -> void:
	print("body entered")
	player.set_physics_process(false)
	black_screen.show()
	fade_anim.play("fade_in")
	switch_timer.start()
	is_path_following = true


func _on_body_exited(body: Node2D) -> void:
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	print("timer out")
	get_tree().call_deferred("change_scene_to_file", "res://area_1.tscn")
