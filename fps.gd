extends Label


func _process(delta):
	text = var2str(stepify((1.0 / delta), 0.1)) + " fps"
