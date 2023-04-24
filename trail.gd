extends Line2D

var length = 5
var point = Vector2()

func _process(delta):
	global_position = Vector2(0, 0)
	global_rotation = 0
	
	point = get_local_mouse_position()
	
	add_point(point)
	
	while get_point_count() > length:
		remove_point(0)
