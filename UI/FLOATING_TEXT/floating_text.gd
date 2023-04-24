extends RichTextLabel

var rng = RandomNumberGenerator.new()
var distance = 10.0
var direction

func _ready():
	rng.randomize()
	direction = Vector2(rng.randf_range(-1.0, 1.0), rng.randf_range(0.0, 1.0)).normalized() * distance
	
	var tween := create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "rect_position", rect_position + direction, 1.0)
	tween.parallel().tween_property(self, "modulate:a", 0.0, 1.0)
	tween.tween_callback(self, "delete_self")

func delete_self():
	get_parent().remove_child(self)
