extends ColorRect

signal server_pressed(ip, port)

var server_info setget set_server_info
func set_server_info(value):
	self.name = value.ip
	self.server_name = value.name
	self.ip = value.ip
	self.port = value.port
	self.max_players = value.max_players
	self.current_players = value.current_players

var server_name: String setget set_server_name
func set_server_name(value):
	server_name = value
	$Control/name.text = value

var ip: String setget set_ip
func set_ip(value):
	ip = value
	$Control/ip.text = value

var port: int setget set_port
func set_port(value):
	port = value
	$Control/port.text = str(value)

var current_players: int setget set_current_players
func set_current_players(value):
	current_players = value
	$Control/current_players.text = str(value)

var max_players: int setget set_max_players
func set_max_players(value):
	max_players = value
	$Control/max_players.text = str(value)

func _ready():
	pass

var click_disabled = false
func _on_item_gui_input(event):
	if event.is_pressed() and not click_disabled:
		emit_signal("server_pressed", ip, port)
		click_disabled = true
