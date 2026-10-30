extends Button

@onready var CombatUI: CanvasLayer = $"../../.."
@onready var move2: Label = $"../S2/Label"
@onready var move3: Label = $"../S3/Label"
@onready var move4: Label = $"../S4/Label"

@onready var move_milestone_1: CanvasLayer = $"../../../Move_Milestone1"

var label:Label
var itemImage:Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		
	label = get_child(0) as Label
	
	if get_child_count() > 1:
		itemImage = get_child(1) as Sprite2D
		
	GameState.move1_selected.connect(update_moves)
	GameState.move2_selected.connect(update_moves)
	update_moves()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_exited() -> void:
	if(name == "simple_attack_button"):
		label.position = Vector2(56.5, 16)
		
	if(name == "S2"):
		label.position =Vector2(56.5, 16)
		
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
		CombatUI.useItem("pumpkin_spice_latte")
		
	if(name == "pumpkin_soup_button"):
		CombatUI.useItem("pumpkin_soup")

	if(name == "pumpkin_pie_button"):
		CombatUI.useItem("pumpkin_pie")


func _on_s_2_pressed() -> void:
	CombatUI.Player_2nd_Spell()


func _on_s_2_mouse_entered() -> void:
	move2.position = Vector2(18, 20)


func _on_s_2_mouse_exited() -> void:
	move2.position = Vector2(18, 16)


func _on_s_3_pressed() -> void:
	CombatUI.Player_3rd_Spell()


func _on_s_3_mouse_entered() -> void:
	move3.position = Vector2(18, 20)


func _on_s_3_mouse_exited() -> void:
	move3.position = Vector2(18, 16)


func _on_s_4_pressed() -> void:
	CombatUI.Player_4th_Spell()


func _on_s_4_mouse_entered() -> void:
	move4.position = Vector2(56.5, 20)


func _on_s_4_mouse_exited() -> void:
	move4.position = Vector2(56.5, 16)

func update_moves():
	move2.text= GameState.player_moveset["S2"]
	move3.text= GameState.player_moveset["S3"]
	move4.text= GameState.player_moveset["S4"]
	
	
