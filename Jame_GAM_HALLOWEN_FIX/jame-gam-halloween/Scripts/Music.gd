extends Node


@onready var player: AudioStreamPlayer = $AudioStreamPlayer


var current_track:= ""


const TRACKS := {
	"menu": preload("res://Assets/Musics/Dreamcore Ice Cream (by juanjo_sound).wav"),
	"final_area": preload("res://Assets/Musics/Ambiance_Forest_Birds_Loop_Stereo.wav"),
	"explore_areas": preload("res://Assets/Musics/05-8bit05loop.ogg"),
	"fighting_area": preload("res://Assets/Musics/SwitchWithMeTheme.wav"),
	"boss": preload("res://Assets/Musics/SwitchWithMeTheme.wav"),
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.bus = "Music"


func play(track_name: String):
	if current_track == track_name and player.playing:
		return
	
	current_track = track_name
	player.stream = TRACKS[track_name]
	player.play()
	
func stop():
	player.stop()
	current_track = ""
