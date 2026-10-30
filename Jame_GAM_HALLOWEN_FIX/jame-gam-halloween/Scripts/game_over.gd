extends Control

@onready var timer: Timer = $Timer
@onready var restart: Button = $Restart
@onready var click: AudioStreamPlayer = $Click

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_pressed() -> void:
	click.play()
	if GameState.final_area_reached:
		get_tree().call_deferred("change_scene_to_file", "res://final_area.tscn")
	else:
		get_tree().call_deferred("change_scene_to_file", "res://main.tscn")


func _on_timer_timeout() -> void:
	restart.show()
