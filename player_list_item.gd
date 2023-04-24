extends PanelContainer

var id setget set_id
func set_id(value):
	id = value
	$c/margin/hbox/Label.text = str(id)

func _ready():
	pass
