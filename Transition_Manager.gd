extends CanvasLayer

onready var level_scenes_node = $"../CLIENT/LEVEL_LAYER"
onready var ui_scenes_node = $"../Menus/MENU"

var transitions = {
	"slide": preload("res://TRANSITIONS/slide_transition.tscn")
}

func create_transition(from_scene, from_type, to_scene, to_type, trantision, params):
	var transition_instance = transitions[trantision].instance()
	self.add_child(transition_instance)
	transition_instance.initialize_transition(from_scene, from_type, to_scene, to_type, params)
