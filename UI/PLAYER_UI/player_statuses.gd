extends Control

var status_scene = preload("res://UI/status/status.tscn")

func _ready():
	pass

func _process(delta):
	for status in singleton.player_unit.get_node("./ownership/status").get_children():
		var exists = false
		for child in get_children():
			if status == child.status_node:
				exists = true
		if not exists:
			var instance = status_scene.instance()
			add_child(instance)
			instance.status_node = status
