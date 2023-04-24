extends Control

var prefab = preload("res://UI/PLAYER_UI/ability_slot.tscn")

onready var abilities_list = $"/root/main/abilities"

func _ready():
	var offset = Vector2(0, 0)
	var i = 0
	for ability in singleton.player_unit.abilities:
		var instance = prefab.instance()
		add_child(instance)
		instance.rect_position += offset
		instance.myInit(abilities_list.get_node(ability), singleton.keybinds_spells[i])
		offset += Vector2(64, 0)
		i += 1
