extends Node2D

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass


func _process(delta):
	if get_global_mouse_position() == position:
		$Sprite.hide()
	else:
		$Sprite.show()
		position = get_global_mouse_position()
