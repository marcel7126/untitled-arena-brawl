extends Node


func _ready():
	singleton.player_unit = get_parent()

