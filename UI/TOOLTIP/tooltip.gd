extends Popup

func tooltip_init(type, content):
	if type == "ability":
		$TextureRect/MarginContainer/VBoxContainer/title.text = content.DISPLAY_NAME
		$TextureRect/MarginContainer/VBoxContainer/body.text = content.tooltip
	if type == "custom":
		$TextureRect/MarginContainer/VBoxContainer/title.text = content.title
		$TextureRect/MarginContainer/VBoxContainer/body.text = content.body
	if type == "status":
		$TextureRect/MarginContainer/VBoxContainer/title.text = content.status_name
		$TextureRect/MarginContainer/VBoxContainer/body.text = content.status_tooltip
