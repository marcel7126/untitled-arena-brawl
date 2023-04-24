extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_max_health_add_pressed():
	singleton.player_unit.add_max_health(50)


func _on_max_health_remove_pressed():
	singleton.player_unit.add_max_health(-50)


func _on_Button_pressed():
	$"../../../../GAMELOOP".set_game_loop_structure("best_of_rounds")
