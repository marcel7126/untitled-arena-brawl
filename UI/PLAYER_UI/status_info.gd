extends Control

onready var tooltip_scene = preload("res://UI/TOOLTIP/tooltip.tscn")

var status_ref setget set_status_ref
func set_status_ref(value):
	status_ref = value
	if not process:
		self.process = true
	if "starting_time" in status_ref:
		$progress.max_value = status_ref.starting_time
	else:
		$h_box/time.text = "INF"
	$h_box/name.text = status_ref.status_name

var process: bool = true setget s_process
func s_process(value):
	process = value
	set_process(value)

func _ready():
	s_process(false)

func _process(delta):
	if not is_instance_valid(status_ref):
		queue_free()
		return
	if "time" in status_ref:
		$progress.value = status_ref.time
		$h_box/time.text = var2str(stepify(status_ref.time, 0.1)) + "s"

var tooltip = null

func _on_status_info_mouse_entered():
	var tooltip_instance = tooltip_scene.instance()
	add_child(tooltip_instance)
	tooltip_instance.tooltip_init("status", status_ref)
	tooltip_instance.show()
	tooltip = tooltip_instance

func _on_status_info_mouse_exited():
	tooltip.queue_free()

