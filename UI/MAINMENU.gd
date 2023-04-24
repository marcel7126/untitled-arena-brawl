extends Control

onready var levelhandler = $"/root/main/CLIENT/LEVEL_LAYER"

func _on_play1_pressed():
	start_game("arena", "res://level1.tscn")

func start_game(gamemode, level):
	levelhandler.add_child(load(level).instance())
	self.hide()
	$"../INGAME".show()
	$"/root/main/CLIENT".show()


func _on_server_list_pressed():
	$server_list.disabled = true
	singleton.transition_manager.create_transition(self, "ui", "res://UI/MENUS/SERVER_BROWSER.tscn", "ui", "slide", [])


func _on_nav_play_pressed():
	$nav_play.disabled = true
	singleton.transition_manager.create_transition(self, "ui", "res://Play_Menu.tscn", "ui", "slide", [])
