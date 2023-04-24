extends Control

var healthbar = preload("res://UI/HEALTHBAR/healthbar_floating.tscn")

func _ready():
	for unit in $"/root/main/CLIENT/units".get_children():
		var instance = healthbar.instance()
		add_child(instance)
		instance.unit = unit
		instance.rect_position = unit.position - singleton.player_unit.position
