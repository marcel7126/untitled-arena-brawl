extends "res://UI/HEALTHBAR/healthbar_base.gd"


func _ready():
	set_process(false)
	self.unit = singleton.player_unit
