extends KinematicBody2D

var team = "neutral"

var abilities = []
var shields = []
var status_effects = []

# STATS    (if stat is not defined or null -> make it zero or like the unit doesnt have the resource/ability at all)

# HEALTH - - - - - - -

var current_health: float = 50 setget set_current_health, get_current_health
func set_current_health(value):
	var relative_value = value - current_health
	current_health = value
	var color = "ffffff"
	if (relative_value > 0):
		color = "50e436"
	if (relative_value < 0):
		color = "c83030"
	create_floating_text(str(relative_value), color)
func get_current_health():
	return current_health

var max_health: float = 50 setget set_max_health, get_max_health
func set_max_health(value):
	max_health = value
func get_max_health():
	var m = get_modifiers("max_health")
	return (((max_health * m.mult) + (max_health * m.add)) * m.mod)

func add_max_health(value):
	max_health += value

var health_regeneration: float setget set_health_regeneration, get_health_regeneration
func set_health_regeneration(value):
	health_regeneration = value
func get_health_regeneration():
	var m = get_modifiers("health_regeneration")
	return (((health_regeneration * m.mult) + (health_regeneration * m.add)) * m.mod)

# MANA - - - - - - -

var current_mana: float setget set_current_mana, get_current_mana
func set_current_mana(value):
	current_mana = value
func get_current_mana():
	return current_mana

var max_mana: float setget set_max_mana, get_max_mana
func set_max_mana(value):
	max_mana = value
func get_max_mana():
	var m = get_modifiers("max_mana")
	return (((max_mana * m.mult) + (max_mana * m.add)) * m.mod)

var mana_regeneration: float setget set_mana_regeneration, get_mana_regeneration
func set_mana_regeneration(value):
	mana_regeneration = value
func get_mana_regeneration():
	var m = get_modifiers("mana_regeneration")
	return (((mana_regeneration * m.mult) + (mana_regeneration * m.add)) * m.mod)

# ENERGY - - - - - - -
var current_energy: float
var max_energy: float
var energy_regeneration: float

# ARMOR & RESISTS
var armor # incoming physical damage reduction (only physical damage)
var magic_resistance # incoming magic damage reduction (only magic damage)
var resistance # general incoming damage reduction (all but true damage)

# MOVEMENT
var move_speed: float = 100 setget set_move_speed, get_move_speed
func set_move_speed(value):
	move_speed = value
func get_move_speed():
	var m = get_modifiers("move_speed")
	return (((move_speed * m.mult) + (move_speed * m.add)) * m.mod)

var slow_resist: float
var movement_speed_modifier

# UTIL
var experience
var level
var gold

var range_ #? i dont plan to implement lol like aa (range will be defined per spell)
var general_range_modifier # well thats like it
var cooldown_modifier

var status_efects_duration_modifier

var heal_and_shield_power
var healing_modifier_general
var shielding_modifier_general

var ability_power
var armor_penetration
var attack_damage
var attack_speed
var critical_strike_chance
var critical_strike_damage
var lifesteal
var magic_penetration
var omnivamp
var physical_damage

var dodge_chance

var knockback_resistance
var knockback_modifier #when inflicting



func get_modifiers(attribute):
	var mod = 1.0 # value of 1
	var add = 0.0 # +0%
	var mult = 1.0 # x100%
	var status = get_node("ownership/status")
	if (status is Node):
		for s in status.get_children():
			if (attribute + "_modifier" in s):
				mod = mod * s.get(attribute + "_modifier")
			if (attribute + "_modifier_additive" in s):
				add += s.get(attribute + "_modifier_additive")
			if (attribute + "_modifier_multiplicative" in s):
				mult = mult * s.get(attribute + "_modifier_multiplicative")
	return {"mod": mod, "add": add, "mult": mult}

func create_floating_text(text, color):
	var instance = load("res://UI/FLOATING_TEXT/floating_text.tscn").instance()
	add_child(instance)
	instance.text = text
	instance.modulate = color

var indicator = preload("res://UI/INDICATORS/projectile_indicator.tscn")
