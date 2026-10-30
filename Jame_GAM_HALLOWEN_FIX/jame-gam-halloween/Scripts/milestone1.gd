extends CanvasLayer

signal move1_selected

@onready var move_milestone_1: CanvasLayer = $"."
@onready var card_select: CanvasLayer = $"."
@onready var label: Label = $Label
@onready var click: AudioStreamPlayer = $Click


var text_speed = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_milestone_1.hide()
	label.visible_ratio = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameState.player_level == 2 and not GameState.move_milestone_1_completed:
		move_milestone_1.show()
		
	if not GameState.move_milestone_1_completed:
		if move_milestone_1.visible:
			label.visible_ratio += text_speed * delta
	


func _on_fire_card_1_pressed() -> void:
	GameState.player_moveset["S2"] = "FIREBALL\nDMG: 8  COST: 10  HIT%: 70"
	GameState.move_milestone_1_completed = true
	click.play()
	
	GameState.move1_selected.emit()
	hide()
	GameState.fireball_picked = true
	

func _on_fire_card_2_pressed() -> void:
	GameState.player_moveset["S2"] = "METEOR\nDMG: 12  COST: 15  HIT%: 45"
	GameState.move_milestone_1_completed = true
	click.play()
	
	GameState.move1_selected.emit()
	hide()
	GameState.meteor_picked = true



	
