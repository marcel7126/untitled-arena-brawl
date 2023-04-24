extends "res://GAME/UNITS/unit.gd"

var shield_example = {
	"type": "normal",
	"value": "50",
	"id": "ability_id_for_example", # if shield still active by ability/... when activated again it isnt duplicated but overriden or refreshed or increased
	"duration": 1.0,
} # shield value can be set(overriden) or changed(adjusted, damage taken)

func _ready():
	abilities = ["fireball", "self_heal", "self_damage", "ability_example"]
	move_speed = 100.0

func damage(amount):
	self.current_health -= amount

func heal(amount):
	self.current_health += amount

