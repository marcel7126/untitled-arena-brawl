extends KinematicBody2D

var team = "neutral"

# ABILITIES
var abilities = ["fireball", "self_heal", "self_damage"]

# STATS
var move_speed = 100 
var current_health = 60 setget set_current_health
var max_health = 100 setget set_max_health

var shields = []

var shield_example = {
	"type": "normal",
	"value": "50",
	"id": "ability_id_for_example", # if shield still active by ability/... when activated again it isnt duplicated but overriden or refreshed or increased
	"duration": 1.0,
} # shield value can be set(overriden) or changed(adjusted, damage taken)

func _ready():
	pass

func damage(amount):
	self.current_health -= amount

func heal(amount):
	self.current_health += amount

func set_current_health(value):
	current_health = value

func set_max_health(value):
	max_health = value
