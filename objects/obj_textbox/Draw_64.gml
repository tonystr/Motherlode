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

if (input(BUTTON.COMMANDLINE, BTYPE.RELEASED)) {
	if (console_active_time) {
		console_active_time = 0;	
	} else {
		console_active = true;
		console_string = "";
		keyboard_string = "";
		input_activate(false);
		console_active_time = 0;
	}
}

if (console_active) {
	//draw_set_valign(fa_bottom);
	var _camwidth  = obj_camera.width;
	var _camheight = obj_camera.height;
	
	var _width = _camwidth * .6;
	var _pad = 2;
	
	draw_set_color(c_black);
	draw_set_alpha(.6);
	draw_rectangle(0, 0 /*_camheight - font_height - _pad*2*/, _width, _camheight, false);
	draw_set_alpha(1);
	draw_set_color(c_white);
	
	if (keyboard_check(vk_anykey)) {
		if (console_active_time++ && keyboard_check(192)) {
			console_active = false;
			console_string = "";
			keyboard_string = "";
			input_activate(true);
		
		} else if (keyboard_check_pressed(vk_enter)) {
			if (console_string != "") {
				console_text += console_name + ": " + console_string + chr(10);
				console_strings_sent[array_length_1d(console_strings_sent)] = console_string;
			
				var _args = string_split(console_string, " ");
				var _scr = commands[? _args[0]];
				
				if (_scr != undefined) {
					var _ret = script_execute(_scr, console_string, _args);
					if (_ret != undefined) console_text += "< " + string(_ret);
				} else console_text += "'" + _args[0] + "' is not recognized as an internal or external command,\noperable program or batch file.";
			
				console_string = "";
				keyboard_string = "";
			}
		} else console_string = keyboard_string;
	}
	draw_text_ext(_pad, _pad - (string_height(console_text) - (_camheight - font_height - _pad * 2)), console_text, font_height, _width - _pad * 2);
	if (console_string != "`") draw_text(_pad, _camheight - _pad - font_height, console_string);
}