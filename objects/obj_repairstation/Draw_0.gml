// Inherit the parent event
draw_self();

if (customer == noone || !instance_exists(customer)) exit;
event_inherited();

surface_set_gui();

var _c = boundary_coordinates;
var _mx = lerp(_c[0], _c[2], .5);
var _my = lerp(_c[1], _c[3], .5);
var _wth = 128;
var _hth = 48;
_my += _hth / 3;
			
var _price = ceil((customer.hull_max - customer.hull) * 10);
var _select = point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _mx - _wth / 2, _my - _hth / 2, _mx + _wth / 2, _my + _hth / 2);
			
draw_set_color((_select ? $5be02f : $56c128));// : $3c6022);
draw_rectangle(_mx - _wth / 2, _my - _hth / 2, _mx + _wth / 2, _my + _hth / 2, false);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_mx, _my - _hth, "$" + string(_price));
draw_text(_mx, _my, "Full Repair");
draw_set_halign(fa_left);
draw_set_valign(fa_top);
			
if (_select && input(BUTTON.SELECT, BTYPE.PRESSED) || mouse_check_button_pressed(mb_left)) {
	with (customer) {
		if (hull == hull_max) {
			textbox_add("Hull is already at max", -1, true);	
		} else if (money == 0) {
			textbox_add("No money left", -1, true);	
		} else {
				
			hull += (min(_price, money) / 10);
			money = max(money - _price, 0);
				
			textbox_add("Hull Repaired  -$" + string(_price));
			if (money == 0) textbox_add("Used all money on repairs", -1, true);
		}
	}
}

surface_reset_target();