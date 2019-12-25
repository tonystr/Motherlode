
if (customer == noone || !instance_exists(customer)) exit;
event_inherited();

var _c = boundary_coordinates;
var _h = 0;
var _total = 0;
var _x = lerp(_c[0], _c[2], .56);
var _midx = lerp(_c[0], _c[2], .5);
var _tdcol = [$7027e5, $dd7e39];
			
draw_line_width_color(_midx, _c[1], _midx, _c[3], 1, _tdcol[0], _tdcol[1]);
			
draw_set_valign(fa_middle);
with(customer) {
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
			
if (input(BUTTON.SELECT, BTYPE.PRESSED) || (
	mouse_check_button_pressed(mb_left) && 
	point_in_rectangle(
		device_mouse_x_to_gui(0), 
		device_mouse_y_to_gui(0), 
		_sx, 
		_sy, 
		_sx + _width, 
		_sy + _height
	)
)) {
	with (customer) {
		money += _total;
		for (var i = 0; i < inv_slots; i++) {
			inv[# i % inv_width, i div inv_width] = ITEM.NONE;
		}
				
		_pressed = true && true;
		inv_filled = 0;
	}
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

draw_set_valign(fa_top);