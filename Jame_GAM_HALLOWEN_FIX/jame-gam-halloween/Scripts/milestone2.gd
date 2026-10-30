extends CanvasLayer

signal move2_selected

@onready var move_milestone_2: CanvasLayer = $"."
@onready var combat_button = get_node("/root/Area1/CombatUI/Panel/Control/simple_attack_button")
@onready var card_select: CanvasLayer = $"."
@onready var combat_ui = get_node("/root/Area1/CombatUI")
@onready var label: Label = $Label

var gust_selected = false
var tornado_selected = false

var select_move = true

var text_speed = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_milestone_2.hide()
	label.visible_ratio = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameState.player_level == 4 and not GameState.move_milestone_2_completed:
		move_milestone_2.show()
		
	if not GameState.move_milestone_1_completed:
		if move_milestone_2.visible:
			label.visible_ratio += text_speed * delta
	

func _on_wind_card_1_pressed() -> void:
	GameState.player_moveset["S3"] = "GUST\nDMG: 7  COST: 10  HIT%: 70"
	GameState.move_milestone_2_completed = true
	GameState.gust_picked = true
	GameState.move2_selected.emit()
	hide()


func _on_wind_card_2_pressed() -> void:
	GameState.player_moveset["S3"] = "TORNADO\nDMG: 12  COST: 15  HIT%: 45"
	GameState.move_milestone_2_completed = true
	GameState.tornado_picked = true
	GameState.move2_selected.emit()
	hide()
