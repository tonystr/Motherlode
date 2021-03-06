// Inherit the parent event

if (customer == noone || !instance_exists(customer)) exit;
event_inherited();

var _c = boundary_coordinates;
var _mx = lerp(_c[0], _c[2], .5);
var _my = lerp(_c[1], _c[3], .5);
var _wth = 128;
var _hth = 48;
_my += _hth / 3;
			
var _price = ceil((customer.fuel_max - customer.fuel) * 2);
var _select = point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _mx - _wth / 2, _my - _hth / 2, _mx + _wth / 2, _my + _hth / 2);
			
draw_set_color((_select ? $5be02f : $56c128));// : $3c6022);
draw_rectangle(_mx - _wth / 2, _my - _hth / 2, _mx + _wth / 2, _my + _hth / 2, false);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_mx, _my - _hth, "$" + string(_price));
draw_text(_mx, _my, "Refuel");
draw_set_halign(fa_left);
draw_set_valign(fa_top);
			
if (input(BUTTON.SELECT, BTYPE.PRESSED) || (_select && mouse_check_button_pressed(mb_left))) {
	with (customer) {
		if (fuel == fuel_max) {
			textbox_add("Fuel is already at max", -1, true);	
		} else if (money == 0) {
			textbox_add("No money left", -1, true);	
		} else {
				
			fuel += (min(_price, money) / 2);
			money = max(money - _price, 0);
				
			textbox_add("Fuel refilled  -$" + string(_price));
			if (money == 0) textbox_add("Used all money on fuel", -1, true);
		}
	}
}