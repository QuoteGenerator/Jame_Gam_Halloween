extends CanvasLayer

@onready var move_milestone_1: CanvasLayer = $"."
@onready var combat_button = get_node("/root/TutorialArea/CombatUI/Panel/Control/simple_attack_button")
@onready var card_select: CanvasLayer = $"."
@onready var combat_ui = get_node("/root/TutorialArea/CombatUI")

var fireball_selected = false
var meteor_selected = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_fire_card_1_pressed() -> void:
	fireball_selected = true
	combat_button.update_moves("FIREBALL")
	move_milestone_1.hide()
	

func _on_fire_card_2_pressed() -> void:
	meteor_selected = true
	combat_button.update_moves("METEOR")
	move_milestone_1.hide()



	
