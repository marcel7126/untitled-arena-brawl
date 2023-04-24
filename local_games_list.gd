extends PanelContainer


var list_item = preload("res://server_list_item.tscn")


func _on_ServerListener_new_server(serverInfo):
	var instance = list_item.instance()
	$vbox.add_child(instance)
	instance.server_info = serverInfo
	instance.connect("server_pressed", self, "_on_server_pressed")


func _on_ServerListener_remove_server(serverIp):
	$vbox.get_node(serverIp.replace(".", "")).queue_free()

func _on_server_pressed(ip, port):
	print(ip, ":", port)
	$"/root/main/network".join_local_game(ip, port)
	singleton.transition_manager.create_transition($"../../../../..", "ui", "res://UI/MENUS/Lobby.tscn", "ui", "slide", [])
