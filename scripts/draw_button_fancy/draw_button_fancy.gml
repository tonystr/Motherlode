/// @func draw_button_fancy();
/// @arg sprite
/// @arg x
/// @arg y
/// @arg toggled flag
/// @arg gui* flag

var _sprite = argument[0];
var _width  = sprite_get_width(_sprite);
var _height = sprite_get_height(_sprite);
var _surf   = surface_create(_width, _height);		
var _x		= argument[1];
var _y		= argument[2];
var _pressd = false;
var _quest  = !argument[3];

var _gui	= argument_count > 4 && argument[4];
var _mousex = _gui ? device_mouse_x_to_gui(0) : mouse_x;
var _mousey = _gui ? device_mouse_y_to_gui(0) : mouse_y;
			
_y += _pressd * 2;
			
surface_set_target(_surf);
	draw_sprite_ext(spr_mouse_light, 
				3, 
				_mousex - _x, 
				_mousey - _y,
				3 * !_pressd, 3 * !_pressd, 0, _quest ? c_fuchsia : c_aqua, 1);
							
	gpu_set_blendmode(bm_subtract);
	draw_sprite(_sprite, 
				2, 
				_width / 2, 
				_height / 2);
							
	gpu_set_blendmode(bm_normal);
surface_reset_target();
			
draw_sprite(_sprite, _quest, _x + _width / 2, _y + _height / 2);
draw_surface(_surf, _x, _y);
surface_free(_surf);

return point_in_rectangle(_mousex, _mousey, _x, _y, _x + _width, _y + _height);