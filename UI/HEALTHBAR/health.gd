extends TextureRect


func _draw():
	var max_value = $"..".max_health
	var value = $"..".health
	
	var bar_height = $"../health_background".rect_size.y
	var bar_width = $"../health_background".rect_size.x
	
	var line_width = 1
	var line_height = bar_height/2
	var line_every_x_hp = 20
	var lines_to_draw = ((max_value) / line_every_x_hp)
	
	var lines = []
	
	if (lines_to_draw > 0):
		var pixel_per_line = ((bar_width) / lines_to_draw)
		var draw_pos_x = pixel_per_line
		for i in int(lines_to_draw):
			#if (draw_pos_x < bar_width):
			if value > 0:
				if ( bar_width / (max_value / value) ) > draw_pos_x :
					draw_line(Vector2(draw_pos_x,0), Vector2(draw_pos_x, line_height), Color.black, line_width)
				#lines.append({"pos": draw_pos_x, "height": line_height, "width": line_width})
			draw_pos_x = draw_pos_x + pixel_per_line
	
	line_width = 1
	line_height = bar_height
	line_every_x_hp = 100
	lines_to_draw = ((max_value) / line_every_x_hp)
	
	if (lines_to_draw > 0):
		var pixel_per_line = ((bar_width) / lines_to_draw)
		var draw_pos_x = pixel_per_line
		for i in int(lines_to_draw):
			#if (draw_pos_x < bar_width):
			if value > 0:
				if ( bar_width / (max_value / value) ) > draw_pos_x :
					draw_line(Vector2(draw_pos_x,0), Vector2(draw_pos_x, line_height), Color.black, line_width)
				#lines.append({"pos": draw_pos_x, "height": line_height, "width": line_width})
			draw_pos_x = draw_pos_x + pixel_per_line
	
	#for l in lines:
		#draw_line(Vector2(l.pos,0), Vector2(l.pos, l.height), Color.black, l.width)
