extends Control

var list_item = preload("res://server_list_item.tscn")


func _on_ServerListener_new_server(serverInfo):
	var instance = list_item.instance()
	$VBoxContainer.add_child(instance)
	instance.server_info = serverInfo
	instance.connect("server_pressed", self, "_on_server_pressed")


func _on_ServerListener_remove_server(serverIp):
	$VBoxContainer.get_node(serverIp.replace(".", "")).queue_free()

func _on_server_pressed(ip, port):
	print(ip, ":", port)
	$"/root/main/network".join_local_game(ip, port)
	singleton.transition_manager.create_transition(self, "ui", "res://UI/MENUS/Lobby.tscn", "ui", "slide", [])



func _on_Button_pressed():
	$Button.disabled = true
	singleton.transition_manager.create_transition(self, "ui", "res://UI/MENUS/MAINMENU.tscn", "ui", "slide", ["ltr"])



func _on_create_local_server_pressed():
	$"/root/main/network".host_local_game(7126)
	$Button.disabled = true
	singleton.transition_manager.create_transition(self, "ui", "res://UI/MENUS/Lobby.tscn", "ui", "slide", [])
