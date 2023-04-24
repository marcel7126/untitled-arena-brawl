extends Node

var status_name = "Zoomies"

var status_tooltip = "+200% Move Speed"

var move_speed_modifier_additive = 2.00

var starting_time = 10 setget set_starting_time
func set_starting_time(value):
	starting_time = value
	time = value

var time = 10

func _physics_process(delta):
	time -= delta
	if time <= 0:
		queue_free()
