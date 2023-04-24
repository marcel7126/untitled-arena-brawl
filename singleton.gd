extends Node

signal player_unit_changed

var cam

var player_unit setget set_player_unit
func set_player_unit(value):
	player_unit = value
	emit_signal("player_unit_changed")

var keybinds_spells = ["lmb", "rmb", "space", "q", "e", "r", "f"]

var team_colors = {
	"player": "dcbb2b",
	"neutral": "ffffff",
	"red": "dc2b2b"
	
}

onready var transition_manager = $"/root/main/Transition_Manager"
onready var ui_layer = $"/root/main/Menus"
onready var level_layer = $"/root/main/CLIENT"

var username setget set_username
func set_username(value):
	username = value
	$"/root/main/Menus/Player_Card/Panel/Label".text = value
