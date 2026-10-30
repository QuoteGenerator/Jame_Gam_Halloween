extends Sprite2D

var speed: float = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= speed * delta
	
	if position.x < 330:
		queue_free() 


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_parent().lose_heart()
		queue_free()
