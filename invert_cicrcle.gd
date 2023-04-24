extends CollisionPolygon2D

export var center: Vector2 = Vector2.ZERO
export var radius: float = 64

func _ready():
	draw_my_shape()

func draw_my_shape():
	var nb_points = 32
	var points_arc = PoolVector2Array()
	#points_arc.push_back(center)
	
	for i in range(nb_points + 1):
		var angle_point = deg2rad(i * 360 / nb_points)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	for i in range(nb_points + 1 - 1, -1, -1):
		var angle_point = deg2rad(i * 360 / nb_points)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * (radius + 16))
	polygon = points_arc
	
	#invert_enable = true


