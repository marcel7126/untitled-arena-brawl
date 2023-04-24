extends PanelContainer


func _ready():
	pass

func _on_create_local_game_pressed():
	$"/root/main/network".host_local_game(7126)
	$vbox/create_local_game.disabled = true
	singleton.transition_manager.create_transition($"../../../../..", "ui", "res://UI/MENUS/Lobby.tscn", "ui", "slide", [])
