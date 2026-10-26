extends Area2D

@onready var player: CharacterBody2D = $"../Path2D/PathFollow2D/Player"
@onready var black_screen: ColorRect = $"../BlackScreen"
@onready var fade_anim: AnimationPlayer = $"../BlackScreen/AnimationPlayer"
@onready var switch_timer: Timer = $"../Timer"

var is_path_following = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	player.set_physics_process(false)
	black_screen.show()
	fade_anim.play("fade_in")
	switch_timer.start()
	is_path_following = true


func _on_body_exited(body: Node2D) -> void:
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	pass # Replace with function body.
