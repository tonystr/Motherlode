// if(live_call()) return live_enabled;

if (draw_menu) {
	
	if (instance_exists(draw_menu)) {
		var _m = draw_menu;
		var _c = _m.boundary_coordinates;
		var _pad = 4;
			
		draw_set_color(_m.boundary_color);
		draw_rectangle(_c[0] - _pad, _c[1] - _pad, _c[2] + _pad, _c[3] + _pad, _m.outline);
		
		if (!_m.outline) {
			_pad /= 2;
			draw_set_color($7027e5);
			draw_line_width(_c[0] - _pad, _c[1] - _pad, _c[0] - _pad, _c[3] + _pad, 1);
			draw_line_width(_c[0] - _pad, _c[1] - _pad, _c[2] + _pad, _c[1] - _pad, 1);
			draw_line_width(_c[2] + _pad, _c[1] - _pad, _c[2] + _pad, _c[3] + _pad, 1);
			draw_line_width(_c[0] - _pad, _c[3] + _pad, _c[2] + _pad, _c[3] + _pad, 1);
		}
	}
	draw_set_color(c_white);
	
	switch (draw_menu) {
		case obj_miningdeposit: #region 
			var _h = 0;
			var _total = 0;
			var _x = lerp(_c[0], _c[2], .56);
			var _midx = lerp(_c[0], _c[2], .5);
			var _tdcol = [$7027e5, $dd7e39];
			
			draw_line_width_color(_midx, _c[1], _midx, _c[3], 1, _tdcol[0], _tdcol[1]);
			
			draw_set_valign(fa_middle);
			for (var i = 1; i < ITEM.COUNT; i++) {
				var _count = inv_item_count(i);
				var _price = ore_price[i] * _count;
				var _size = 32;
				var _y = _c[1] + _size * _h + _size/2;
				
				_total += _price;
				
				if (_count) {
					draw_sprite(ore_sprite[i], 0, _x, _c[1] + _size * _h);
					var _sw = string_width(" ");
					if (_count > 1) {
						draw_text(_x + _size + _sw * 7, _y, string(_count));
						draw_sprite(spr_x, 0, _x + _size + _sw * 3.5, _y);
					}
					
					draw_set_halign(fa_right);
					draw_text(_c[2], _y, "=  $ " + string(_price));
					draw_set_halign(fa_left);
					
					_h++;
				}
			}
			
			draw_set_valign(fa_bottom);
			var _fh = string_height("ASWD/6iagdiuTL");
			var _off = 5;
			draw_line_width_color(_midx, _c[3] - _fh - _off, _c[2], _c[3] - _fh - _off, 1, merge_color(_tdcol[0], _tdcol[1], ((_c[3] - _fh - _off) - _c[1]) / (_c[3] - _c[1])), $4adb73);
			draw_text(_x, _c[3] - 1, "Total:  $ " + string(_total));
			
			var _width  = sprite_get_width(spr_sell);
			var _height = sprite_get_height(spr_sell);
			var _surf   = surface_create(_width, _height);
			
			var _sx = lerp(_c[0], _midx, .5) - _width / 2;
			var _sy = lerp(_c[1], _c[3], .5) - _height / 2 + (_total <= 0);
			var _pressed = false;
			
			if (input(BUTTON.SELECT, BTYPE.PRESSED) || 
				(mouse_check_button_pressed(mb_left) && point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _sx, _sy, _sx + _width, _sy + _height))) {
				money += _total;
				for (var i = 0; i < inv_slots; i++) {
					inv[# i % inv_width, i div inv_width] = ITEM.NONE;
				}
				
				_pressed = true && true;
				inv_filled = 0;
				
			}
			
			_sy += _pressed * 2;
			
			surface_set_target(_surf);
				draw_sprite_ext(spr_mouse_light, 
							3, 
							mouse_x - (obj_camera.x - obj_camera.width / 2)  - _sx, 
							mouse_y - (obj_camera.y - obj_camera.height / 2) - _sy,
							3 * !_pressed, 3 * !_pressed, 0, _total <= 0 ? c_fuchsia : c_aqua, 1);
							
				gpu_set_blendmode(bm_subtract);
				draw_sprite(spr_sell, 
							2, 
							_width / 2, 
							_height / 2);
							
				gpu_set_blendmode(bm_normal);
			surface_reset_target();
			
			draw_sprite(spr_sell, _total <= 0, _sx + _width / 2, _sy + _height / 2);
			draw_surface(_surf, _sx, _sy);
			surface_free(_surf);
		break; #endregion
		case obj_emendationstation: #region
			var _mod  = 3;
			var _size = 32;
			var _pad  = 16;
			var _x = _c[0];
			var _y = _c[1];
			
			var _mgx = floor((device_mouse_x_to_gui(0) - (_c[0] + _pad / 2)) / (_size + _pad));
			var _mgy = floor((device_mouse_y_to_gui(0) - (_c[1] + _pad / 2)) / (_size + _pad));
			
			// Button
			var _sprite = spr_buy;
			var _width  = sprite_get_width(_sprite);
			var _height = sprite_get_height(_sprite);
			var _x = lerp(_c[0], _c[2], .75) - _width / 2;
			var _y = lerp(_c[1], _c[3], .75) - _height / 2;
			var _buyi = menu_selectx + menu_selecty * 3;
			var _buyable = (_buyi >= 0 && _buyi < 6) && money >= item_price[_buyi];
			var _pressed = false;
			
			if (input(BUTTON.SELECT, BTYPE.PRESSED) || 
				(mouse_check_button_pressed(mb_left) && 
				point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _x + _width, _y + _height))) {
				
				if (_buyable) {
					money -= item_price[_buyi];
					item[_buyi]++;
				}
				
				_pressed = true;
			}
			
			draw_button_fancy(_sprite, _x, _y + _pressed * 2, _buyable, true);
			
			if (!_pressed) {
				if (mouse_check_button_pressed(mb_left) || input(BUTTON.SELECT, BTYPE.PRESSED)) {
					menu_selectx = _mgx;
					menu_selecty = _mgy;
					menu_string = "";
				}
			}
			
			var _item_price = "";
			var _selecti = menu_selectx + menu_selecty * 3;
			var _selected_something = false;
			if (_selecti >= 0 && _selecti < 6) {
				var item_str  = item_name[_selecti];
				menu_string_xoff = -string_width(item_name[_selecti]) / 2;
				_selected_something = true;
				_item_price = "$ " + string(item_price[_selecti]);
				
				if (item_str != menu_string) {
				
					var _mstr_len = string_length(menu_string);
					if (menu_string == string_copy(item_str, 1, _mstr_len)) {
						if (menu_string_counter++ % (room_speed div 16) == 0) {
							
							menu_string += string_char_at(item_str, _mstr_len + 1);
						}
					} else {
						menu_string = "";
						menu_string_counter = 0;
					}
				}
			}
			
			for (var i = 0; i < item_count; i++) {
				var _ix = i  %  _mod;
				var _iy = i div _mod;
				var _x = _c[0] + _pad + _ix * (_size + _pad);
				var _y = _c[1] + _pad + _iy * (_size + _pad);
				var _selected = _ix == _mgx && _iy == _mgy;
				
				if (_selected) {
					draw_set_alpha(.1);
					draw_rectangle(_x - _pad / 2, _y - _pad / 2 + 1, _x + 32 + _pad / 2 - 2, _y + 32 + _pad / 2 - 1, false);
					draw_set_alpha(1);	
				}
				
				if (_ix == menu_selectx && _iy == menu_selecty) {
					
					draw_sprite_ext(item_sprite[i], 0, _x + 1, _c[1] + _pad + (i div _mod) * (_size + _pad), 1, 1, 0, c_black, 1);	
					draw_sprite_ext(item_sprite[i], 0, _x, _c[1] + _pad + (i div _mod) * (_size + _pad) - 1, 1, 1, 0, c_black, 1);
					draw_sprite_ext(item_sprite[i], 0, _x - 1, _c[1] + _pad + (i div _mod) * (_size + _pad), 1, 1, 0, c_black, 1);
					draw_sprite_ext(item_sprite[i], 0, _x, _c[1] + _pad + (i div _mod) * (_size + _pad) + 1, 1, 1, 0, c_black, 1);
				}
				
				draw_sprite(item_sprite[i], 0, _x, _c[1] + _pad + (i div _mod) * (_size + _pad));	
			}
			
			var _midx = lerp(_c[0], _c[2], .75);
			
			draw_text(_midx + menu_string_xoff, lerp(_c[1], _c[3], .31), menu_string);
			draw_text(_midx - string_width(_item_price) / 2, lerp(_c[1], _c[3], .48), _item_price);
			
		break; #endregion
	}
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	
} else if (inv_visible) {
	
	var _inv_y_span = obj_camera.height - inv_slot_size * inv_height;
	var _cor_x = (obj_camera.width  - inv_slot_size * inv_width) / 2;
	var _cor_y = -obj_camera.y_offset + _inv_y_span / 2 - 64;
	var _inv_x = x - obj_camera.x + _cor_x;
	var _inv_y = y - obj_camera.y + _cor_y;
	
	if (mouse_check_button_pressed(mb_left)) {
		var _gmx = floor((mouse_x + obj_camera.width  / 2 - obj_camera.x - _inv_x) / inv_slot_size);
		var _gmy = floor((mouse_y + obj_camera.height / 2 - obj_camera.y - _inv_y) / inv_slot_size);
	
		if (median(_gmx, 0, inv_width)  == _gmx &&
			median(_gmy, 0, inv_height) == _gmy) {
			
			var _drop = inv[# _gmx, _gmy];
			if (_drop) {
				inv[# _gmx, _gmy] = 0;
				inv_filled--;
				textbox_add("Dropped " + ore_name[_drop], -1, true);
			}
		}
	}
	
	draw_set_alpha(.84);
	for (var _y = 0; _y < inv_height; _y++) {
		for (var _x = 0; _x < inv_width; _x++) {
			draw_set_color(_y * inv_width + _x < inv_slots ? $471a24 : $240b87);
			draw_rectangle(_inv_x + inv_slot_size * _x + 1,
						   _inv_y + inv_slot_size * _y + 1,
						   _inv_x + inv_slot_size * (_x+1) - 2,
						   _inv_y + inv_slot_size * (_y+1) - 2,
						   false);
			
			var _cell = inv[# _x, _y];
			if (_cell > 0) {
				draw_sprite(ore_sprite[_cell], 0, _inv_x + inv_slot_size * _x,
						   _inv_y + inv_slot_size * _y);
			}
		}
	}
	
	var _xoff = 4;
	var _size = 32;
	var _w = _size * 2.4;
	
	var _i = 0;
	for (var i = 0; i < item_count; i++) _i += item[i] && 1;
	
	if (_i) {
		draw_rectangle(_inv_x + inv_width * inv_slot_size + 1, 
					   _inv_y + 1,
					   _inv_x + inv_width * inv_slot_size + _w,
					   _inv_y + _i * _size - 1,
					   false);
	}
	
	draw_set_alpha(1);
	draw_set_color(c_white);
	
	draw_set_halign(fa_right);
	draw_set_valign(fa_middle)
	
	var _i = 0;
	for (var i = 0; i < item_count; i++) {
		if (item_sprite[i] + 1 && item[i]) {
			var _x = _inv_x + inv_width * inv_slot_size + _xoff;
			var _y = _inv_y + _i++ * _size;
			
			draw_sprite(item_sprite[i], 0, _x, _y);
			draw_sprite(spr_x, 0, _x + _size + 3, _y + _size / 2);
			
			draw_text(_x + _w * .9, _y + _size / 2, string(item[i]));
		}
	}
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
} 

var _hullpx, _shrink;
var _y = 2;
var _x = 2;
var _fh = string_height("OUADBynbasdnio/") + 2;
if (hull > 0) {
	_hullpx = ((hull - 2.4) / (hull_max - 2.4)) * 19;
	_shrink = min(hull, 3) / 3;

	if (_shrink == 1) draw_sprite_ext(spr_hull_bar, 1, _x, _y, _shrink, _shrink, 0, c_white, 1);
	if (_shrink == 1) draw_sprite_ext(spr_hull_bar, 2, _x, _y + 28, 1, -(hull / hull_max) * .7, 0, c_white, 1);
	draw_sprite_ext(spr_hull_bar, 3, _x + (1 - _shrink) * 16, _y + (1 - _shrink) * 28 - _hullpx + (1 - _shrink), _shrink, _shrink, 0, c_white, 1);
}
draw_sprite(spr_hull_bar, 0, _x, _y);

_x += 30;

if (fuel > 0) {
	_hullpx = ((fuel - 2.4) / (fuel_max - 2.4)) * 19;
	_shrink = min(fuel, 3) / 3;

	if (_shrink == 1) draw_sprite_ext(spr_fuel_bar, 1, _x, _y, _shrink, _shrink, 0, c_white, 1);
	if (_shrink == 1) draw_sprite_ext(spr_fuel_bar, 2, _x, _y + 28, 1, -(fuel / fuel_max) * .7, 0, c_white, 1);
	draw_sprite_ext(spr_fuel_bar, 3, _x + (1 - _shrink) * 16, _y + (1 - _shrink) * 28 - _hullpx + (1 - _shrink), _shrink, _shrink, 0, c_white, 1);
}
draw_sprite(spr_fuel_bar, 0, _x, _y);

_x -= 30;
_y += 32;
draw_text(_x, _y, "Depth: " + string(-ceil(y / 6.4)) + "ft");
_y += _fh;
draw_text(_x, _y, "$ " + string(money));
_y += _fh;