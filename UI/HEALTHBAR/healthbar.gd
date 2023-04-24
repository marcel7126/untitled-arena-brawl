extends Control

var hb_height = 8.0 setget set_hb_height
func set_hb_height(value):
	hb_height = value
	$health.rect_size.y

var hb_width = 64.0 setget set_hb_width
func set_hb_width(value):
	hb_width = value
	$health.rect_size.x

var dmg_takem_bar = preload("res://UI/HEALTHBAR/recently_taken_damage.tscn")

var unit setget set_unit

func set_unit(value):
	unit = value
	var color = singleton.team_colors[unit.team]
	if unit.get_node_or_null("player_controlled_unit"):
		color = "dcbb2b"
	$health.tint_progress = color

var health = 1.0 setget set_health
var max_health = 100.0 setget set_max_health

func _ready():
	pass

func _process(_delta):
	rect_position = unit.position - singleton.cam.position + Vector2(1024 / 2, 600/2) - self.rect_size / 2 + Vector2(0, -30)
	
	if health != unit.current_health:
		self.health = unit.current_health
	if max_health != unit.max_health:
		self.max_health = unit.max_health
	
	if unit.get_node_or_null("cast") != null:
		$status.text = "casting"
	else:
		$status.text = ""
func damage_indicator(damage_taken):
	var instance = dmg_takem_bar.instance()
	$health.add_child(instance)
	instance.healthbar = self
	instance.before = health
	instance.value = damage_taken
	instance.max_health = max_health
	instance.health_bar_width = $health.rect_size.x

func set_health(value):
	var isLower = false
	if health > value:
		isLower = true
	health = value
	if isLower:
		damage_indicator($health.value - health)
	$health.value = health
	$health_text.text = str(health) + "/" + str(unit.max_health)

func set_max_health(value):
	max_health = value
	$health.max_value = max_health
	$health_text.text = str(health) + "/" + str(unit.max_health)
	$health.update()
