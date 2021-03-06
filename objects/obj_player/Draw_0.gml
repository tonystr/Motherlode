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
		draw_sprite(comp_sprite("hull"), 0, 32, 32);
		draw_sprite(comp_sprite("treads"), image_index, 32, 32);
		draw_sprite(comp_sprite("exhaust"), 0, 32, 32);
	
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
					comp_sprite("drill"), 0,
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