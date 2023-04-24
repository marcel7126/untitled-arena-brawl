extends Sprite

func _process(delta):
	position = singleton.player_unit.position
	rotation = singleton.player_unit.get_local_mouse_position().normalized().angle()
