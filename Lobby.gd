extends Node


func get_lobby_list():
	var lobby_list = []
	for user in get_children():
		if not user.is_queued_for_deletion():
			lobby_list.append({"id": user.name})
	return lobby_list
