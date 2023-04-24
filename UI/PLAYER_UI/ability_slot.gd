extends Control

var slot = ""

var ability

var cooldown = 10
var timer = 0

var damage = 0
var heal = 0

onready var cooldown_progress = $TextureProgress
onready var cooldown_time_label = $time

onready var tooltip = preload("res://UI/TOOLTIP/tooltip.tscn")

func _ready():
	pass

func myInit(_ability, _slot):
	ability = _ability
	cooldown = ability.cooldown
	slot = _slot
	$slot_name.text = slot

func use():
	if singleton.player_unit.get_node_or_null("cast") != null:
		return
	if timer <= 0:
		get_node("/root/main/abilities/ABILITY_CAST").cast(ability, singleton.player_unit, self)

func put_on_cooldown():
	timer = cooldown

func _process(delta):
	if timer > 0:
		timer -= delta
		cooldown_progress.value = (timer / cooldown) * 100
		cooldown_time_label.text = var2str(stepify(timer, 0.1)) + "s"

func _input(event):
	if event.is_action_pressed(slot):
		use()

func _on_TextureRect_gui_input(event):
	if event is InputEventMouseButton:
		use()
		#print(event)


func _on_ability_slot_mouse_entered():
	var tooltip_instance = tooltip.instance()
	add_child(tooltip_instance)
	tooltip_instance.tooltip_init("ability", ability)
	tooltip_instance.show()

func _on_ability_slot_mouse_exited():
	get_node("tooltip").queue_free()
