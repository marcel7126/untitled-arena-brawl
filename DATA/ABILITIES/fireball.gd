extends Node

var projectile = preload("res://GAME/ABILITIES/fireball.tscn")

var DISPLAY_NAME = "Fireball"
var description = "Shoots a ball of fire"
var tooltip = "Fires a fireball dealing 20 damage"
var damage = 20
var cooldown = 0.2
var casttime = 0.2
var projectile_range = 700
var projectile_width = 8

func active(caster):
	var instance = projectile.instance()
	get_node("/root/main/CLIENT").add_child(instance)
	instance.caster = caster
	instance.team = caster.team
	instance.position = caster.position
	instance.starting_position = caster.position
	instance.damage = damage
	instance.max_distance = projectile_range
	instance.direction = singleton.player_unit.get_local_mouse_position().normalized()
