// if(live_call()) return live_enabled;
var i;

var _rx = 0;
var _ry = 0;

if (drill) {
	_rx = random(1.2) - .6;
	_ry = random(1.2) - .6;
	
	x += _rx;
	y += _ry;
}

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale_draw, image_yscale_draw, image_angle_draw, image_blend, image_alpha);
	
var _modules = [module_active, module_prev];
module_interp++;

for (var i = 0; i < 2; i++) {
	if (_modules[i] < 0) continue;
	
	var _sub_count = sprite_get_number(module_sprite[_modules[i]]);
	if (!i || module_interp < _sub_count) {
		var _index = module_interp > _sub_count ? module_interp : 
					 (i ? min(module_interp, _sub_count - 1) : 
					 max(0, _sub_count - module_interp));
				 
		var _sprite_type = module_interp > _sub_count ? module_sprite_anim : 
						   module_sprite;
	
		var _dir = point_direction(0, 0, module_xoffset[_modules[i]] * image_xscale_draw, module_yoffset[_modules[i]] * image_yscale_draw);
		var _dis = point_distance(0, 0, module_xoffset[_modules[i]] * image_xscale_draw, module_yoffset[_modules[i]] * image_yscale_draw);
		draw_sprite_ext(_sprite_type[_modules[i]], 
						_index, 
						x + lengthdir_x(_dis, _dir + image_angle_draw), 
						y + lengthdir_y(_dis, _dir + image_angle_draw), 
						image_xscale_draw, 
						image_yscale_draw, 
						image_angle_draw,
						image_blend,
						image_alpha);
	}
}

x -= _rx;
y -= _ry;