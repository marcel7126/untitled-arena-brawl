extends Control


func _ready():
	pass

var node_from
var node_type

var scene_to
var scene_type

var slide_frames = []

func initialize_transition(from_scene, from_type, to_scene, to_type, params):
	node_from = from_scene
	node_type = from_type
	scene_to = to_scene
	scene_type = to_type
	
	slide_frames = [
		Vector2(get_viewport().size.x, 0),
		Vector2.ZERO,
		Vector2(-get_viewport().size.x, 0)
		]
	if params != []:
		if params.has("ltr"):
			slide_frames.invert()
		if params.has("ttb"):
			slide_frames = [
		Vector2(0, -get_viewport().size.y),
		Vector2.ZERO,
		Vector2(0, get_viewport().size.y)
		]
	
	start_transition()

func start_transition():
	$rect/loading.modulate.a = 0.0
	$rect.rect_position = slide_frames[0]
	self.show()
	var tween := create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property($rect, "rect_position", slide_frames[1], .5)
	tween.tween_callback(self, "loading")

var time = 10.0
func loading():
	time = 10.0
	var timer_tween := create_tween()
	timer_tween.tween_property(self, "time", 0.0, 0.1)
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
	tween.tween_property($rect, "rect_position", slide_frames[2], .5)
