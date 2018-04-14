// if(live_call()) return live_enabled;

draw_set_font(global.font);
font_height = string_height("ASWD/6iagdiuTL");

if (instance_exists(obj_camera)) {
	var _size = ds_list_size(messages);
	if (_size > 0) {
		var _width  = obj_camera.width;
		var _height = obj_camera.height;

		draw_set_halign(fa_right);
	
		for (var i = 0; i < _size; i++) {
			draw_text(_width - 2, 2 + font_height * (message_timer[| i]++ / 60), messages[| i]);
			if (message_timer[| i] >= message_time[| i]) {
				textbox_remove(i--);
				_size--;
			}
		}

		draw_set_halign(fa_left);
		time++;
	} else time = font_height;
}
