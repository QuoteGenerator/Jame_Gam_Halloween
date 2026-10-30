extends Node2D

@onready var label: Label = $Camera2D/Label
@onready var label_2: Label = $Camera2D/Label2
@onready var label_3: Label = $Camera2D/Label3
@onready var label_4: Label = $Camera2D/Label4
@onready var label_5: Label = $Camera2D/Label5
@onready var label_6: Label = $Camera2D/Label6
@onready var label_7: Label = $Camera2D/Label7
@onready var label_8: Label = $Camera2D/Label8
@onready var label_9: Label = $Camera2D/Label9
@onready var label_10: Label = $Camera2D/Label10
@onready var label_11: Label = $Camera2D/Label11

var current_line = 1

var text_speed = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.visible_ratio = 0
	label_2.visible_ratio = 0
	label_3.visible_ratio = 0
	label_4.visible_ratio = 0
	label_5.visible_ratio = 0
	label_6.visible_ratio = 0
	label_7.visible_ratio = 0
	label_8.visible_ratio = 0
	label_9.visible_ratio = 0
	label_10.visible_ratio = 0
	label_11.visible_ratio = 0
	
	label.show()
	label_2.hide()
	label_3.hide()
	label_4.hide()
	label_5.hide()
	label_6.hide()
	label_7.hide()
	label_8.hide()
	label_9.hide()
	label_10.hide()
	label_11.hide()
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_line == 12:
			get_tree().call_deferred("change_scene_to_file", "res://main.tscn")
	
	
	var current_label: Label
	
	match current_line:
		
		1: current_label = label
		2: current_label = label_2
		3: current_label = label_3
		4: current_label = label_4
		5: current_label = label_5
		6: current_label = label_6
		7: current_label = label_7
		8: current_label = label_8
		9: current_label = label_9
		10: current_label = label_10
		11: current_label = label_11
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
		4: label_4.show()
		5: label_5.show()
		6: label_6.show()
		7: label_7.show()
		8: label_8.show()
		9: label_9.show()
		10: label_10.show()
		11: label_11.show()
		_: current_line = 12
			
			
