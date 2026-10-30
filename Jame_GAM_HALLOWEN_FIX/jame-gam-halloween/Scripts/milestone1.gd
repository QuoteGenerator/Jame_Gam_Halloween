extends CanvasLayer

signal move3_selected

@onready var move_milestone_3: CanvasLayer = $"."
@onready var card_select: CanvasLayer = $"."
@onready var label: Label = $Label
@onready var click: AudioStreamPlayer = $Click


var text_speed = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_milestone_3.hide()
	label.visible_ratio = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameState.player_level == 6 and not GameState.move_milestone_3_completed:
		move_milestone_3.show()
		
	if not GameState.move_milestone_3_completed:
		if move_milestone_3.visible:
			label.visible_ratio += text_speed * delta
	


func _on_earth_card_1_pressed() -> void:
	GameState.player_moveset["S4"] = "ROCK THROW\nDMG: 8  COST: 10  HIT%: 70"
	GameState.move_milestone_3_completed = true
	click.play()
	
	GameState.move3_selected.emit()
	hide()
	GameState.rockthrow_picked = true
	

func _on_earth_card_2_pressed() -> void:
	GameState.player_moveset["S4"] = "BRICK THROW\nDMG: 12  COST: 15  HIT%: 45"
	GameState.move_milestone_3_completed = true
	click.play()
	
	GameState.move3_selected.emit()
	hide()
	GameState.brickthrow_picked = true
