// if(live_call()) return live_enabled;

draw_set_font(fnt_pixel);
font_height = string_height("ASWD/6iagdiuTL");

if (instance_exists(obj_camera)) {
	var _size = ds_list_size(messages);
	if (_size > 0) {
		var _width  = obj_camera.width;
		var _height = obj_camera.height;

		draw_set_halign(fa_right);
		draw_set_font(fnt_pixel);
	
		for (var i = _size - 1; i >= 0; i--) {
			draw_text(_width - 2, 2 + font_height * i + time/3, messages[| i]);	
		}
		
		if (time > 0 && (time % (font_height * 3)) == 0) {
			ds_list_delete(messages, 0);
		}

		draw_set_halign(fa_left);
		time++;
	} else time = font_height;
}
