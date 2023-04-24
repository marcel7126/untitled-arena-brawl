extends Node

var projectile_indicator = preload("res://UI/INDICATORS/projectile_indicator.tscn")
var melee_indicator = preload("res://UI/INDICATORS/projectile_indicator.tscn")
var area_of_effect_indicator = preload("res://UI/INDICATORS/projectile_indicator.tscn")

func cast(ability, caster, ability_slot):
	if "casttime" in ability:
		if ability.casttime != null:
			singleton.player_unit.add_child(preload("res://GAME/UNITS/cast.tscn").instance())
			var indicator_instance = projectile_indicator.instance()
			get_node("/root/main/CLIENT").add_child(indicator_instance)
			indicator_instance.get_node("sprite").scale = Vector2(ability.projectile_range, ability.projectile_width)
			yield(get_tree().create_timer(ability.casttime), "timeout")
			indicator_instance.queue_free()
			ability_slot.put_on_cooldown()
			caster.get_node("cast").queue_free()
	ability.active(caster)

func indicator_projectile():
	pass

func indicator_melee():
	pass

func indicator_area_of_effect():
	pass
