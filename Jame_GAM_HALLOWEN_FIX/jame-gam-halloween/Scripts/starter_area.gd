extends Node2D

@onready var black_screen: ColorRect = $BlackScreen
@onready var fade_anim: AnimationPlayer = $BlackScreen/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	black_screen.show()
	fade_anim.play("fade_out")
	
	Music.play("explore_areas")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
