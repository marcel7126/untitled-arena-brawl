extends Area2D

var team
var caster

var damage = 0.0
var velocity = Vector2(0, 0)
var direction = Vector2(0, 0)
var speed = 500

var max_distance = 50.0
var starting_position = Vector2(0, 0)

func _ready():
	pass

func _physics_process(delta):
	if position.distance_to(starting_position) > max_distance:
		queue_free()
		return
	global_position += speed * direction * delta

func _on_Node2D_body_entered(body):
	if body == caster:
		return
	print(body)
	if "current_health" in body:
		get_node("/root/main/CLIENT/units/"+body.name).current_health = body.current_health - damage
		var impact = preload("res://GAME/impact.tscn").instance()
		get_node("/root/main/CLIENT").add_child(impact)
		impact.position = position
		impact.emitting = true
		impact.modulate = "e14812"
		queue_free()
