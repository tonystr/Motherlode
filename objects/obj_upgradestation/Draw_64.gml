if (customer == noone || !instance_exists(customer)) exit;
event_inherited();

var _mod  = 4;
var _c = boundary_coordinates;
var _size = 16;
var _pad  = 16;
var _x = _c[0];
var _y = _c[1];

show_debug_message("ord ? :");
show_debug_message(ord("?"))

var _mgx = floor((device_mouse_x_to_gui(0) - (_c[0] + _pad / 2)) / (_size + _pad));
var _mgy = floor((device_mouse_y_to_gui(0) - (_c[1] + _pad / 2 + _pad * 2)) / (_size + _pad));

// Button
var _sprite = spr_buy;
var _width  = sprite_get_width(_sprite);
var _height = sprite_get_height(_sprite);
var _x = lerp(_c[0], _c[2], .75) - _width / 2;
var _y = lerp(_c[1], _c[3], .75) - _height / 2;
var _buyi = menu_selectx + menu_selecty * _mod;
var _buyable = (_buyi >= 0 && _buyi < 6) && customer.money >= upgrade_price[COMP.DRILL, _buyi];
var _pressed = false;

if (input(BUTTON.SELECT, BTYPE.PRESSED) || 
	(mouse_check_button_pressed(mb_left) && 
	point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _x + _width, _y + _height))) {

	if (_buyable) {
		customer.money -= upgrade_price[COMP.DRILL, _buyi];
		set_comp(COMP.DRILL, upgrade[_buyi], customer);
		textbox_add("+1 " + upgrade_name[COMP.DRILL, _buyi]);
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
var _selecti = menu_selectx + menu_selecty * _mod;
var _selected_something = false;
if (_selecti >= 0 && _selecti < UPTYPE.SIZE) {
	var item_str  = upgrade_name[COMP.DRILL, _selecti];
	menu_string_xoff = -string_width(item_str) / 2;
	_selected_something = true;
	_item_price = "$ " + string(upgrade_price[COMP.DRILL, _selecti]);
		
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

for (var i = 0; i < UPTYPE.SIZE; i++) {
	var _ix = i  %  _mod;
	var _iy = i div _mod;
	var _x = _c[0] + _pad + _ix * (_size + _pad);
	var _y = _c[1] + _pad * 3 + _iy * (_size + _pad);
	var _spy = _c[1] + _pad * 3 + (i div _mod) * (_size + _pad);
				
	if (_ix == _mgx && _iy == _mgy) {
		draw_set_alpha(.1);
		draw_rectangle(_x - _pad / 2, _y - _pad / 2 + 1, _x + _size + _pad / 2 - 2, _y + _size + _pad / 2 - 1, false);
		draw_set_alpha(1);
	}
	
	if (_ix == menu_selectx && _iy == menu_selecty) {
		draw_sprite_ext(upgrade[COMP.DRILL, i], 0, _x + 1, _spy, 1, 1, 0, c_black, 1);	
		draw_sprite_ext(upgrade[COMP.DRILL, i], 0, _x, _spy - 1, 1, 1, 0, c_black, 1);
		draw_sprite_ext(upgrade[COMP.DRILL, i], 0, _x - 1, _spy, 1, 1, 0, c_black, 1);
		draw_sprite_ext(upgrade[COMP.DRILL, i], 0, _x, _spy + 1, 1, 1, 0, c_black, 1);
	}
	
	draw_sprite(upgrade[COMP.DRILL, i], 0, _x, _spy);	
}

var _midx = lerp(_c[0], _c[2], .75);

draw_text(_midx + menu_string_xoff, lerp(_c[1], _c[3], .31), menu_string);
draw_text(_midx - string_width(_item_price) / 2, lerp(_c[1], _c[3], .48), _item_price);