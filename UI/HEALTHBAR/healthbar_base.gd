extends Control

func _ready():
	set_process(false)

export var hb_height = 2.0 setget set_hb_height
func set_hb_height(value):
	hb_height = value
	if self.has_node("health"):
		$health.rect_size.y = value
	if self.has_node("health_background"):
		$health_background.rect_size.y = value
	if self.has_node("arrow"):
		$arrow.position.y = value

export var hb_width = 64.0 setget set_hb_width
func set_hb_width(value):
	hb_width = value
	if self.has_node("health"):
		$health.rect_size.x = value
	if self.has_node("health_background"):
		$health_background.rect_size.x = value

var dmg_takem_bar = preload("res://UI/HEALTHBAR/recently_taken_damage.tscn")

var unit setget set_unit
func set_unit(unit_):
	unit = unit_
	var color = singleton.team_colors[unit_.team]
	if unit.get_node_or_null("player_controlled_unit"):
		color = "dcbb2b"
	$health.self_modulate = color
	set_hb_height(hb_height)
	set_hb_width(hb_width)
	set_health(unit.current_health)
	set_max_health(unit.max_health)
	set_process(true)

var health = 1.0 setget set_health
func set_health(value):
	var prev = health
	var isLower = false
	if health > value:
		isLower = true
	health = value
	if isLower:
		damage_indicator(prev - health)
	set_current_health_indicator()
	$health_text.text = str(health) + "/" + str(unit.max_health)

var max_health = 100.0 setget set_max_health
func set_max_health(value):
	max_health = value
	set_current_health_indicator()
	$health_text.text = str(health) + "/" + str(unit.max_health)
	$health.update()

func set_current_health_indicator():
	var new_rect_size = (hb_width / max_health) * health
	if new_rect_size > hb_width:
		new_rect_size = hb_width
	$health.rect_size.x = new_rect_size

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
	instance.value = damage_taken

