extends Control

onready var player_list = get_node("vsplit/Container/mc/hsplit/vsplit/Panel/player_list")
var player_list_item = preload("res://player_list_item.tscn")

func _ready():
	$"/root/main/network".connect("lobby_changed", self, "_on_lobby_changed")
	$"/root/main/network".send_request_player_lobby(get_instance_id())
	print("request sent")

func _on_lobby_changed_old(list):
	$list.clear()
	for user in list:
		$list.text += user.id + "\n"

func _on_lobby_changed(list):
	var local_list = player_list.get_children()
	for user in list:
		if local_list.has(user.id):
			local_list.erase(user.id)
		else:
			var pl_instance = player_list_item.instance()
			player_list.add_child(pl_instance)
			pl_instance.name = user.id
			pl_instance.id = user.id
	for item in local_list:
		item.queue_free()

onready var leave_button = get_node("vsplit/head/leave_lobby")
func _on_leave_lobby_pressed():
	if get_tree().is_network_server():
		$"/root/main/network".close_server()
	else:
		$"/root/main/network".network.close_connection()
	leave_button.disabled = true
	singleton.transition_manager.create_transition(self, "ui", "res://Play_Menu.tscn", "ui", "slide", ["ltr"])

func return_player_lobby(data):
	_on_lobby_changed(data)
