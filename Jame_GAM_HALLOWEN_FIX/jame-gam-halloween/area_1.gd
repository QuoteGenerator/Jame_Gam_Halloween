extends Node2D

@onready var black_screen: ColorRect = $BlackScreen
@onready var path_follower: PathFollow2D = $Path2D/PathFollow2D
@onready var fade_anim: AnimationPlayer = $BlackScreen/AnimationPlayer
@onready var player: CharacterBody2D = $Player
@onready var remote_transform: RemoteTransform2D = $Path2D/PathFollow2D/RemoteTransform2D
@onready var ghost_enemy: CharacterBody2D = $GhostEnemy

@onready var path_follower_ghost: PathFollow2D = $Path2D3/PathFollow2D
@onready var remote_transform_ghost: RemoteTransform2D = $Path2D3/PathFollow2D/RemoteTransform2D

# Called when the node enters the scene tree for the first time.
var is_path_following = false
var is_ghost_following = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	black_screen.show()
	is_path_following = true
	is_ghost_following = true
	fade_anim.play("fade_out")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_path_following:
		player.set_physics_process(false)
		path_follower.progress_ratio += 0.011
		
	if is_ghost_following:
		path_follower_ghost.progress_ratio += 0.011
		
	if path_follower.progress_ratio >= 1:
		player.set_physics_process(true)
		remote_transform.remote_path = NodePath("")
		
	if is_instance_valid(ghost_enemy):
		if ghost_enemy.chasing:
			remote_transform_ghost.remote_path = NodePath("")
