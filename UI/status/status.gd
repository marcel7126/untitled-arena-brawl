extends Node

onready var tooltip = preload("res://UI/TOOLTIP/tooltip.tscn")

var status_node

func _ready():
	pass

func _process(delta):
	if not is_instance_valid(status_node):
		queue_free()
		return

func _on_status_mouse_entered():
	var tooltip_instance = tooltip.instance()
	add_child(tooltip_instance)
	tooltip_instance.tooltip_init("status", status_node)
	tooltip_instance.show()

func _on_status_mouse_exited():
	get_node("tooltip").queue_free()
