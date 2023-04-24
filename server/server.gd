extends Node

const DEFAULT_IP = "localhost"
const DEFAULT_PORT = 7126

var network = NetworkedMultiplayerENet.new()

var selected_ip
var selected_port

var local_player_id
sync var players = {}
sync var player_data = {}

func _ready():
	pass
