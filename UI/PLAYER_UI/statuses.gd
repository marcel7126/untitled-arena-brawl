extends VFlowContainer

var status_info_scene = preload("res://UI/PLAYER_UI/status_info.tscn")

func _process(delta):
	for status in singleton.player_unit.get_node("./ownership/status").get_children():
		var exists = false
		for child in get_children():
			if status == child.status_ref:
				exists = true
		if not exists:
			var instance = status_info_scene.instance()
			add_child(instance)
			instance.status_ref = status
