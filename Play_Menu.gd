extends Control


func _ready():
	pass


func _on_return_pressed():
	$return.disabled = true
	singleton.transition_manager.create_transition(self, "ui", "res://UI/MENUS/MAINMENU.tscn", "ui", "slide", ["ltr"])
