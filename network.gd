extends Node

var network = NetworkedMultiplayerENet.new()

var DEFAULT_PORT = 7126
var DEFAULT_IP = "localhost"

var is_running: bool = false

var is_player_server: bool = true

func _ready():
	network.connect("peer_connected", self, "_peer_connected")
	network.connect("peer_disconnected", self, "_peer_disconnected")
	network.connect("connection_failed", self, "_on_connection_failed")
	network.connect("connection_succeeded", self, "_on_connection_succeeded")

func host_local_game(port):
	if is_running:
		return
	
	for child in $Lobby.get_children():
		child.queue_free()
	
	if not port:
		port = DEFAULT_PORT
	
	#var network = NetworkedMultiplayerENet.new()
	network.create_server(port)
	get_tree().set_network_peer(null)
	get_tree().set_network_peer(network)
	
	is_running = true
	print("server started")
	
	local_server_info_broadcast(port)
	
	
	if is_player_server == true:
		lobby_add_player(get_tree().get_network_unique_id())

func _peer_connected(player_id):
	if not get_tree().is_network_server():
		return
	print("user " + str(player_id) + " connected")
	rpc("spawn_connected_player", player_id)
	handle_player_connected(player_id)

func _peer_disconnected(player_id):
	if not get_tree().is_network_server():
		return
	print("user " + str(player_id) + " disconnected")
	rpc("despawn_disconnected_player", player_id)
	handle_player_disconnected(player_id)

func join_local_game(ip, port):
	if not ip:
		ip = DEFAULT_IP
	if not port:
		port = DEFAULT_PORT
	
	for child in $Lobby.get_children():
		child.queue_free()
	
	network.create_client(ip, port)
	get_tree().set_network_peer(null)
	get_tree().set_network_peer(network)
	

func _on_connection_failed():
	print("failed to connect")

func _on_connection_succeeded():
	print("succefully connected")

func local_server_info_broadcast(port):
	var advertiser = preload("res://server_advertiser_node.tscn").instance()
	self.add_child(advertiser)
	advertiser.serverInfo["name"] = singleton.username
	advertiser.serverInfo["port"] = port
	advertiser.serverInfo["max_players"] = 0#MAX_PLAYERS
	advertiser.serverInfo["current_players"] = 0#current_players
	#version (to prevent connecting to old/new game version)

func kill_broadcast():
	get_node("ServerAdvertiser").queue_free()

func close_server():
	$"/root/main/network".kill_broadcast()
	network.close_connection()
	for child in $Lobby.get_children():
		child.queue_free()
	#if get_tree().is_network_server():
	#get_tree().network_peer = null
	is_running = false
	print("server stopped")
	
# ------------------------- testing functions
master func generic_server_only():
	#should only be called when instance is server
	print("server only function called")
	$"../Menus/MENU/INGAME/dev/dev_output".text += "server only function called\n"

puppet func generic_client_only():
	#should only be called when instance is client
	print("client only fuction called")
	$"../Menus/MENU/INGAME/dev/dev_output".text += "client only fuction called\n"

remotesync func generic_all():
	#should be called on both server and client instance
	print("function called on both")
	$"../Menus/MENU/INGAME/dev/dev_output".text += "function called on both\n"


remotesync func generic_all_server():
	#should be called on both server and client instance
	#but check for server
	if not is_network_master():
		return
	print("function called on server")
	$"../Menus/MENU/INGAME/dev/dev_output".text += "function called on server\n"

remotesync func generic_all_client():
	#should be called on both server and client instance
	#but check for client
	if is_network_master():
		return
	print("function called on client")
	$"../Menus/MENU/INGAME/dev/dev_output".text += "function called on client\n"


func _on_server_pressed():
	#rpc("generic_server_only")
	rpc("generic_all_server")

func _on_client_pressed():
	#rpc("generic_client_only")
	rpc("generic_all_client")

func _on_both_pressed():
	rpc("generic_all")
# ------------------------------- end of testing functions


# client server code


var has_lobby = true
var state = "lobby"

func handle_player_connected(player_id):
	if has_lobby == true:
		lobby_add_player(player_id)

func handle_player_disconnected(player_id):
	if has_lobby == true:
		lobby_remove_player(player_id)

signal lobby_changed(list)
var player_card = preload("res://player_card.tscn")

func lobby_add_player(player_id):
	var instance = player_card.instance()
	$Lobby.add_child(instance)
	instance.name = str(player_id)
	rpc("emit_lobby_changed", $Lobby.get_lobby_list())

func lobby_remove_player(player_id):
	$Lobby.get_node(str(player_id)).queue_free()
	var lobby_list = []
	for x in $Lobby.get_children():
		lobby_list.append({"id": x.name})
	rpc("emit_lobby_changed", $Lobby.get_lobby_list())

remotesync func emit_lobby_changed(list):
	emit_signal("lobby_changed", list)


func send_request_player_lobby(instance):
	rpc("handle_request_player_lobby", instance)
master func handle_request_player_lobby(instance):
	print("request to resolve")
	if get_tree().get_rpc_sender_id() == 1:
		feedback_request_player_lobby($Lobby.get_lobby_list(), instance)
		return
	rpc_id(get_tree().get_rpc_sender_id(), "feedback_request_player_lobby", $Lobby.get_lobby_list(), instance)
remote func feedback_request_player_lobby(data, instance):
	instance_from_id(instance).return_player_lobby(data)
	print("request result received")


# temp part of game sync

remotesync func spawn_connected_player(player_id):
	var unit = preload("res://GAME/UNITS/unit.tscn").instance()
	$"../CLIENT/units".add_child(unit)
	unit.name = str(player_id)
	
	if get_tree().get_network_unique_id() == player_id:
		singleton.player_unit = unit

remotesync func despawn_disconnected_player(player_id):
	$"../CLIENT/units".get_node(str(player_id)).queue_free()
	








