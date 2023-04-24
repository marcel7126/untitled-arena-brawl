extends Camera2D

func _ready():
	singleton.cam = self

func _process(delta):
	position = singleton.player_unit.position + get_local_mouse_position() / 2
