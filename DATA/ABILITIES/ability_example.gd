extends Node

var projectile = preload("res://GAME/ABILITIES/fireball.tscn")

var DISPLAY_NAME = "Example Projectile"
var DESCRIPTION = "Shoots an example projectile"
var TOOLTIP = {}
var tooltip = "Fires an example projectile dealing 10 damage"

var damage = 20

var cooldown = 1.0
var casttime = 0.5

var projectile_range = 500
var projectile_width = 10


func passive(caster):
	return # example: timer to execute something periodicaly # NOTE: if passive have cooldown, its not implemented to show on ability icon

func active(caster):
	active_old(caster) # example: shoots, called when ability is pressed

func active_old(caster):
	
	var instance = projectile.instance()
	get_node("/root/main/CLIENT").add_child(instance)
	instance.caster = caster
	instance.team = caster.team
	instance.position = caster.position
	instance.starting_position = caster.position
	instance.damage = damage
	instance.max_distance = projectile_range
	instance.direction = singleton.player_unit.get_local_mouse_position().normalized()
