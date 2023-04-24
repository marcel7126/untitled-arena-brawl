extends Node2D

var PLAYER_INSTANCE

var velocity = Vector2()

func _ready():
	_on_player_unit_changed()
	singleton.connect("player_unit_changed", self, "_on_player_unit_changed")

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("player_move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("player_move_right"):
		velocity.x += 1
	if Input.is_action_pressed("player_move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("player_move_down"):
		velocity.y += 1
	velocity = velocity.normalized() * PLAYER_INSTANCE.move_speed

func _physics_process(delta):
	if PLAYER_INSTANCE.get_node_or_null("cast") != null:
		return
	get_input()
	velocity = PLAYER_INSTANCE.move_and_slide(velocity)

func _on_player_unit_changed():
	PLAYER_INSTANCE = singleton.player_unit
