extends Button

@onready var CombatUI: CanvasLayer = $"../../.."

var label:Label
var itemImage:Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label = get_child(0) as Label
	
	if get_child_count() > 1:
		itemImage = get_child(1) as Sprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_exited() -> void:
	if(name == "simple_attack_button"):
		label.position = Vector2(56.5, 16)
		
	if(name == "pumpkin_spice_latte_button"):
		label.position.y = 15
		itemImage.position.y = 27
		
	if(name == "pumpkin_soup_button"):
		label.position.y = 15
		itemImage.position.y = 27
		
	if(name == "pumpkin_pie_button"):
		label.position.y = 15
		itemImage.position.y = 27

func _on_mouse_entered() -> void:
	if(name == "simple_attack_button"):
		label.position = Vector2(56.5, 20)
		
	if(name == "pumpkin_spice_latte_button"):
		label.position.y = 18
		itemImage.position.y = 30
	if(name == "pumpkin_soup_button"):
		label.position.y = 18
		itemImage.position.y = 30
	if(name == "pumpkin_pie_button"):
		label.position.y = 18
		itemImage.position.y = 30

func _on_pressed() -> void:
	if(name == "simple_attack_button"):
		CombatUI.Player_Basic_Attack()
		
	if(name == "pumpkin_spice_latte_button"):
		pass
		
	if(name == "pumpkin_soup_button"):
		pass

	if(name == "pumpkin_pie_button"):
		pass
