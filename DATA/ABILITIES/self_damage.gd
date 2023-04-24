extends Node

var DISPLAY_NAME = "Self-Damage"
var description = "Hurts yourself"
var tooltip = "Deals 10 damage"
var damage = 20
var cooldown = 0.0

func active(caster):
	caster.damage(damage)
