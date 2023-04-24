extends Control

var texture = load("res://UI/HEALTHBAR/RESOURCES/hpbar_red.tres")
var healthbar setget set_healthbar
func set_healthbar(healthbar_):
	healthbar = healthbar_
	before = healthbar_.health
	max_health = healthbar_.max_health
	health_bar_width = healthbar_.hb_width
	health_bar_height = healthbar_.hb_height

var value = 1.0
var max_health = 100.0

var before = 1.0

var health_bar_width = 2.0
var health_bar_height = 1.0

func _ready():
	helo()
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_interval(0.2)
	tween.tween_property(self, "value", 0.0, 0.5)

func _process(delta):
	var offset = 0.0
	
	var found_self = false
	
	for bar in get_parent().get_children():
		if found_self == true:
			offset += bar.value
		if bar == self:
			found_self = true
	
	before = offset + healthbar.health
	
	if value == 0:
		queue_free()
	helo()

func helo():
	var height = health_bar_height
	var width = 0
	if value > 0:
		width = ( health_bar_width / (max_health / value) )
	var pos = 0
	if before > 0:
		pos = ( health_bar_width / (max_health / before) )
	rect_position = Vector2(pos, 0)
	rect_size = Vector2(width, height)
