extends Node

var DISPLAY_NAME = "Self-Heal"
var description = "Heals yourself"
var tooltip = "Heals for 25 HP"
var heal = 20
var cooldown = 0.2

func active(caster):
	caster.heal(heal)
