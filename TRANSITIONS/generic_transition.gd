extends Control


func _ready():
	pass

var node_from
var node_type

var scene_to
var scene_type

func initialize_transition(from_scene, from_type, to_scene, to_type):
	node_from = from_scene
	node_type = from_type
	scene_to = to_scene
	scene_type = to_type
	
	start_transition()

func start_transition():
	$rect/loading.modulate.a = 0.0
	$rect.rect_position.x = get_viewport().size.x
	self.show()
	var tween := create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property($rect, "rect_position", Vector2(0, 0), .5)
	tween.tween_callback(self, "loading")

var time = 10.0
func loading():
	time = 10.0
	var timer_tween := create_tween()
	timer_tween.tween_property(self, "time", 0.0, 1.0)
	timer_tween.tween_callback(self, "finish_transition")
	
	var tween_fade_in := create_tween()
	tween_fade_in.tween_property($rect/loading, "modulate", Color(1,1,1,1), 1.0)
	var tween_rotation := create_tween().set_loops()
	tween_rotation.tween_property($rect/loading, "rotation_degrees", 360.0, 2.0).from(0.0)

func finish_transition():
	var instance = load(scene_to).instance()
	singleton.ui_layer.get_node("MENU").add_child(instance)
	node_from.queue_free()
	
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	var tween := create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property($rect, "rect_position", Vector2(0 - get_viewport().size.x, 0), .5)
