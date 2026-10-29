extends Node2D

@onready var label: Label = $Camera2D/Label
@onready var label_2: Label = $Camera2D/Label2
@onready var label_3: Label = $Camera2D/Label3

var current_line = 1

var text_speed = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.visible_ratio = 0
	label_2.visible_ratio = 0
	label_3.visible_ratio = 0
	
	label.show()
	label_2.hide()
	label_3.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var current_label: Label
	
	match current_line:
		
		1: current_label = label
		2: current_label = label_2
		3: current_label = label_3
		_: return
	
	if current_label.visible_ratio < 1:
		current_label.visible_ratio += text_speed * delta
	
	if Input.is_action_just_pressed("Interact"):
		if current_label.visible_ratio < 1:
			current_label.visible_ratio = 1
		else:
			current_label.hide()
			next_line()
			
	
func next_line():
	current_line += 1
	
	match current_line:
		2: label_2.show()
		3: label_3.show()
		_: current_line = 4
			
			
