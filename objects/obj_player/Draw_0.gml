// if(live_call()) return live_enabled;

var _rx = 0;
var _ry = 0;

if (drill) {
	_rx = random(1.2) - .6;
	_ry = random(1.2) - .6;
	
	x += _rx;
	y += _ry;
}

if (!surface_exists(draw_surf)) draw_surf = surface_create(64, 64);
surface_set_target(draw_surf);
	draw_clear_alpha(c_white, 0);

	if (state != state_player_death) {
		draw_sprite(comp_sprite[COMP.HULL], 0, 32, 32);
		draw_sprite(comp_sprite[COMP.TREADS], image_index, 32, 32);
		draw_sprite(comp_sprite[COMP.EXHAUST], 0, 32, 32);
	
		var _modules = [module_active, module_prev];
		module_interp++;
		
		for (var i = 0; i < 2; i++) {
			if (_modules[i] < 0) continue;
	
			var _sub_count = sprite_get_number(module_sprite[_modules[i]]);
			if (i && module_interp >= _sub_count) continue;
				
			var _index = module_interp > _sub_count ? module_interp : 
							(i ? min(module_interp, _sub_count - 1) : 
							max(0, _sub_count - module_interp));
				 
			var _sprite_type = module_interp > _sub_count ? module_sprite_anim : module_sprite;
	
			var _dir = point_direction(0, 0, module_xoffset[_modules[i]], module_yoffset[_modules[i]]);
			var _dis = point_distance(0, 0, module_xoffset[_modules[i]], module_yoffset[_modules[i]]);
			draw_sprite_ext(_sprite_type[_modules[i]], 
							_index, 
							32 + lengthdir_x(_dis, _dir), 
							32 + lengthdir_y(_dis, _dir), 
							1, 1, 1, c_white, 1);
							
			if (_modules[i] == MODULE.DRILL_X || _modules[i] == MODULE.DRILL_Y) { 
				var _frac = 1 - clamp(_index / _sub_count, 0, 1);
				if (_frac == 0) _frac = 1;
				draw_sprite_general(
					comp_sprite[COMP.DRILL], 0,
					(1 - _frac) * 12, 0, _frac * 12, 16,
					40 + 7    * (_modules[i] == MODULE.DRILL_X),
					15 + 19	  * (_modules[i] == MODULE.DRILL_Y),
					1, 1, 270 * (_modules[i] == MODULE.DRILL_Y),
					c_white, c_white, c_white, c_white, 1);
			}
		}
	} else draw_sprite(sprite_index, image_index, 32, 32);
surface_reset_target();

var _dir = point_direction(0, 0, image_xscale_draw * 32, 32) + image_angle_draw;
var _dis = point_distance( 0, 0, image_xscale_draw * 32, 32);

draw_surface_ext(draw_surf, 
				 x - lengthdir_x(_dis, _dir), 
				 y - lengthdir_y(_dis, _dir), 
				 image_xscale_draw, 
				 image_yscale_draw, 
				 image_angle_draw, 
				 image_blend, 
				 image_alpha);
/*
draw_circle(drill_grid_x * obj_world.grid_size, drill_grid_y * obj_world.grid_size, 3, true);

with (obj_world) {
	var _y = other.y div grid_size;
	var _x = other.x div grid_size;
	
	var _chunk_x = _x div chunk_width;
	var _chunk_y = _y div chunk_height;
	
	draw_text(_x * grid_size, _y * grid_size, "Chunk[" + string(floor(_chunk_x)) + ":" + string(floor(_chunk_x == 0 ? _x : _x % chunk_width)) + ", " + string(floor(_chunk_y)) + ":" + string(floor(_chunk_y == 0 ? _y : _y % chunk_height)) + "]");
}*/

x -= _rx;
y -= _ry;


/// GUI

surface_set_gui();

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

if (!surface_exists(gui_surf)) gui_surf = surface_create(obj_camera.width, obj_camera.height);

surface_set_target(gui_surf);
	draw_clear_alpha(hit_timer > 0 ? c_red : c_white, hit_timer / hit_time);

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

	_x = 2;
	_y += 32;
	draw_text(_x, _y, "Depth: " + string(-ceil(y / 6.4)) + "ft");
	_y += _fh;
	draw_text(_x, _y, "$ " + string(money));
	_y += _fh;
	
surface_reset_target();
draw_surface_ext(gui_surf, 0, 0, 1, 1, 0, c_white, sprite_index == spr_explosion ? 1 - image_index / image_number : 1);

if (state == state_player_death) {
	
}

surface_reset_target();