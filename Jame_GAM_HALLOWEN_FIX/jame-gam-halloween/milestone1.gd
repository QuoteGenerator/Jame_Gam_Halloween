extends CanvasLayer

@onready var move_milestone_1: CanvasLayer = $"."
@onready var combat_button = get_node("/root/TutorialArea/CombatUI/Panel/Control/simple_attack_button")
@onready var card_select: CanvasLayer = $"."
@onready var combat_ui = get_node("/root/TutorialArea/CombatUI")
@onready var label: Label = $Label

var fireball_selected = false
var meteor_selected = false

var select_move = true

var text_speed = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_milestone_1.hide()
	label.visible_ratio = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameState.player_level == 2 and select_move:
		move_milestone_1.show()
		select_move = false
		
	if not select_move:
		label.visible_ratio += text_speed * delta
	


func _on_fire_card_1_pressed() -> void:
	fireball_selected = true
	combat_button.update_moves("FIREBALL")
	move_milestone_1.hide()
	

func _on_fire_card_2_pressed() -> void:
	meteor_selected = true
	combat_button.update_moves("METEOR")
	move_milestone_1.hide()



	
