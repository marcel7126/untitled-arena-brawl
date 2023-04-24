extends Control


func _ready():
	pass

var bool_input: bool = false
func _input(event):
	if not event.is_pressed() or bool_input:
		return
	bool_input = true
	var tween := create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property($center, "rect_position:y", 0.0, 0.5)
	tween.parallel().tween_property($"Img2942(360x270)", "modulate:v", 0.2, 0.5)
	tween.parallel().tween_property($hint_text, "modulate:a", 0.0, 0.2)


func _on_commit_login_pressed():
	singleton.username = $center/panel/margin/hbox/vbox/username_input.text
	#$center/panel/hbox/vbox/commit_login.disabled = true
	singleton.transition_manager.create_transition(self, "ui", "res://UI/MENUS/MAINMENU.tscn", "ui", "slide", [])
