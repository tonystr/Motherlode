// if(live_call()) return live_enabled;

var _top  = (y + height / 2) / depth_change;
var _topf = floor(_top);
var _frac = frac(_top);

if (_topf >= 0 && _topf < depth_color_count - 2) {

	var _color_top	  = merge_color(depth_color[_topf	 ], depth_color[_topf + 1], _frac);
	var _color_bottom = merge_color(depth_color[_topf + 1], depth_color[_topf + 2], _frac);

	draw_rectangle_color(x - width / 2, 
						 y - height / 2, 
						 x + width / 2,
						 y + height / 2,
						 _color_top,
						 _color_top,
						 _color_bottom,
						 _color_bottom,
						 false);
}

for (var i = 0; i < sky_color_count - 1; i++) {
	draw_rectangle_color(x - width / 2, -height * i, x + width * 2, -height * (i + 1), sky_color[i+1], sky_color[i+1], sky_color[i], sky_color[i], false);
}

if (!surface_exists(sky_surf)) sky_surf = surface_create(width, height);
surface_set_target(sky_surf);
	draw_clear_alpha(c_white, 0);
	planet_angle += planet_angle_speed;
	var _x = width -  width / 2 + lengthdir_x(height*.6, planet_angle);
	var _y = height / 1.5 + lengthdir_y(height*.6, planet_angle);
	draw_sprite_angle(spr_earth, 0, _x, _y, planet_angle);
	draw_sprite_angle(spr_moon,  0, _x + lengthdir_x(34, planet_angle + 12), _y + lengthdir_y(34, planet_angle + 15), planet_angle);
surface_reset_target();
draw_surface_part(sky_surf, 0, 0, width, min(max(0, height / 2 - y), height), x - width / 2,  y - height / 2);

draw_sprite_tiled_h(spr_bg_mars, 0, x * .71, 0, x - width / 2, x + width / 2);