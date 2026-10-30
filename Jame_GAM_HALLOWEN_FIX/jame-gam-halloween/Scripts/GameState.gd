extends Node

signal move1_selected
signal move2_selected

var difficulty:String = "normal"

var player_level: int = 1

var player_health: int = 25
var player_max_health: int = 25

var player_mana: int = 25
var player_max_mana: int = 25

var damage_multiplier = 1.0

var items:Array = [
		{"Amount": 0, "Name": "pumpkin_pie"}, 
		{"Amount": 0, "Name": "pumpkin_soup"}, 
		{"Amount": 0, "Name": "pumpkin_spice_latte"}
	]

var player_moveset = {
	"S2": "",
	"S3": "",
	"S4": ""
}

var fireball_picked = false
var meteor_picked = false
var gust_picked = false
var tornado_picked = false

var move_milestone_1_completed = false
var move_milestone_2_completed = false
var move_milestone_3_completed = false

var start_minigame = false
