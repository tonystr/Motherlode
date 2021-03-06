
if (inv_visible) {
	
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

if (hit_timer > 0) draw_rect(0, 0, obj_camera.width, obj_camera.height, c_red, hit_timer / hit_time);

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

#region Fuel

if (fuel > 0) {
	_hullpx = ((fuel - 2.4) / (fuel_max - 2.4)) * 19;
	_shrink = min(fuel, 3) / 3;
		
	if (_shrink == 1) draw_sprite_ext(spr_fuel_bar, 1, _x, _y, _shrink, _shrink, 0, c_white, 1);
	if (_shrink == 1) draw_sprite_ext(spr_fuel_bar, 2, _x, _y + 28, 1, -(fuel / fuel_max) * .7, 0, c_white, 1);
	draw_sprite_ext(spr_fuel_bar, 3, _x + (1 - _shrink) * 16, _y + (1 - _shrink) * 28 - _hullpx + (1 - _shrink), _shrink, _shrink, 0, c_white, 1);
}
draw_sprite(spr_fuel_bar, 0, _x, _y);
if (fuel < fuel_max / 4.5) {
	draw_set_font(fnt_pixel8);
	var _critical = fuel < fuel_max / 9;
	var _max   = room_speed * (_critical ? .05 : .1);
	var _blink = (step / _max) % _max < _max * .5;
	
	draw_set_color($442730);
	draw_set_alpha(.4);
	draw_text(_x + 25, _y + 21, _critical ? "FUEL CRITICAL!" : "FUEL LOW");
	draw_set_color(_blink ? c_white : c_red);
	draw_set_alpha(1);
	draw_text(_x + 26, _y + 20, _critical ? "FUEL CRITICAL!" : "FUEL LOW");
	draw_set_color(c_white);
}

#endregion;

_x = 2;
_y += 32;
draw_text(_x, _y, "Depth: " + string(-ceil(y / 6.4)) + "ft");
_y += _fh;
draw_text(_x, _y, "$ " + string(money));
_y += _fh;

if (state == state_player_death) {
	
}
