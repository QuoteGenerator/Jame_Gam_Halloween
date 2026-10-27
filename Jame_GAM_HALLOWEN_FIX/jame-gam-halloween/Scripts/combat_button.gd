extends Button

@onready var label: Label = $Label
@onready var CombatUI: CanvasLayer = $"../../.."



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_exited() -> void:
	label.position = Vector2(56.5, 16)


func _on_mouse_entered() -> void:
	label.position = Vector2(56.5, 20)

func _on_pressed() -> void:
	CombatUI.Player_Basic_Attack()
