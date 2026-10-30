extends Node


@onready var player: AudioStreamPlayer = $AudioStreamPlayer

var current_track:= ""


const TRACKS := {
#	"menu": preload("res://Music/Dreamcore Tone (by juanjo_sound).wav"),
#	"opening_cs": preload("res://Music/Ambiance_Forest_Birds_Loop_Stereo.wav"),
#	"starter_area": preload("res://Music/Dreamcore Ice Cream (by juanjo_sound).wav"),
	"fighting_area": preload("res://Assets/Musics/SwitchWithMeTheme.wav"),
#	"boss": preload("res://Music/LonePeakMusic - 22 Phobos -Retro Gaming Version-.wav"),
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func play(track_name: String):
	if current_track == track_name and player.playing:
		return
	
	current_track = track_name
	player.stream = TRACKS[track_name]
	player.play()
	
func stop():
	player.stop()
	current_track = ""
