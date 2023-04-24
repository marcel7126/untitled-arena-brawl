extends Polygon2D

func _ready():
	draw_my_shape()

func draw_my_shape():
	polygon = get_parent().polygon


func _process(delta):
	draw_my_shape()
