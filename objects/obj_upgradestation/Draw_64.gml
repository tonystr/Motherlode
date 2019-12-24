/// @desc Menu logic

if (customer == noone || !instance_exists(customer)) exit;
event_inherited();

var _comps_size = ds_list_size(components);

var _comp_map = components[| tab];
var _data = _comp_map[? "data"];
var _asize = ds_list_size(_data);

var _mod  = 4;
var _c = boundary_coordinates;
var _size = 16;
var _pad  = 16;
var _x = _c[0];
var _y = _c[1];

var _mgx = floor((device_mouse_x_to_gui(0) - (_c[0] + _pad / 2)) / (_size + _pad));
var _mgy = floor((device_mouse_y_to_gui(0) - (_c[1] + _pad / 2 + _pad * 2)) / (_size + _pad));

// Button
var _sprite = spr_buy;
var _width  = sprite_get_width(_sprite);
var _height = sprite_get_height(_sprite);
var _x = lerp(_c[0], _c[2], .75) - _width / 2;
var _y = lerp(_c[1], _c[3], .75) - _height / 2;
var _buyi = menu_selectx + menu_selecty * _mod;
var _buyable = false;
if (_buyi >= 0 && _buyi < 6) {
	var _comp = _data[| _buyi]
	_buyable = customer.money >= _comp[? "price"];
}
var _pressed = false;

// Button presses
if (input(BUTTON.SELECT, BTYPE.PRESSED) || mouse_check_button_pressed(mb_left)) {
		
	// Buy button
	if (_buyable && point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _x + _width, _y + _height)) {
		customer.money -= _comp[? "price"];
		set_comp(_comp_map[? "name"], _comp, customer);
		textbox_add("+1 " + _comp[? "type"] + " " + _comp_map[? "name"]);
		_pressed = true;
		
	// tab buttons
	} else if (_mgy == -1 && _mgx >= 0 && _mgx < _comps_size) {
		tab = _mgx;
	}
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
if (_selecti >= 0 && _selecti < _asize) {
	
	var _comp = _data[| _selecti];
	
	var item_str = _comp[? "type"] + " " + _comp_map[? "name"];
	menu_string_xoff = -string_width(item_str) / 2;
	_selected_something = true;
	_item_price = "$ " + string(_comp[? "price"]);
	
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

// Tabs
draw_set_color($7027e5);
var _pd = 4;
//draw_line_width(_c[0] - _pd, _c[1] + _pd + _size * 2, _c[0] + _size * _comps_size, _c[1] + _pd + _size * 2, 1);
draw_rect(
	_c[0],
	_c[1],
	_c[2] + _pd / 2,
	_c[1] + _pad * 2 + _pd * 2 + 1,
	c_black,
	.2
);
draw_set_color(c_white);
for (var i = 0; i < _comps_size; i++) {
	
	//if (!array_length_2d(upgrade, i)) continue;
	
	var _ix = i;
	var _iy = -1;
	var _x = _c[0] + _pad + _ix * (_size + _pad);
	var _y = _c[1] + _pad;
	var _spy = _c[1] + _pad + (i div _mod) * (_size + _pad);
				
	if (_ix == _mgx && _iy == _mgy) {
		draw_set_alpha(.1);
		draw_rectangle(_x - _pad / 2, _y - _pad / 2 + 1, _x + _size + _pad / 2 - 2, _y + _size + _pad / 2 - 1, false);
		draw_set_alpha(1);
	}
	
	//if (_ix == menu_selectx && _iy == menu_selecty) {
	//	draw_sprite_ext(upgrade[tab, i], 0, _x + 1, _spy, 1, 1, 0, c_black, 1);	
	//	draw_sprite_ext(upgrade[tab, i], 0, _x, _spy - 1, 1, 1, 0, c_black, 1);
	//	draw_sprite_ext(upgrade[tab, i], 0, _x - 1, _spy, 1, 1, 0, c_black, 1);
	//	draw_sprite_ext(upgrade[tab, i], 0, _x, _spy + 1, 1, 1, 0, c_black, 1);
	//}
	
	var _comp_first = components[| i];
	var _name = _comp_first[? "name"];
	var _data = _comp_first[? "data"];
	var _comp = _data[| 0];
	var _spr  = asset_get_index("spr_" + _name + "_" + _comp[? "type"]);
	
	var _offx = sprite_get_xoffset(_spr) - sprite_get_width(_spr)  / 2;
	var _offy = sprite_get_yoffset(_spr) - sprite_get_height(_spr) / 2;
	
	draw_sprite(_spr, 0, _x + _offx + 8, _spy + _offy + 8);	
}

var _comp_map = components[| tab];
var _data = _comp_map[? "data"];

for (var i = 0, _asize = ds_list_size(_data); i < _asize; i++) {
	
	var _comp_map = components[| tab];
	var _name = _comp_map[? "name"];
	var _data = _comp_map[? "data"];
	var _comp = _data[| i];
	var _spr  = asset_get_index("spr_" + _name + "_" + _comp[? "type"]);
	
	var _ix = i  %  _mod;
	var _iy = i div _mod;
	var _x = _c[0] + _pad + _ix * (_size + _pad);
	var _y = _c[1] + _pad * 3 + _iy * (_size + _pad);
	var _dx = _x + (sprite_get_xoffset(_spr) - sprite_get_width(_spr) / 2) + 8;
	var _spy = _c[1] + _pad * 3 + (i div _mod) * (_size + _pad) + (sprite_get_yoffset(_spr) - sprite_get_height(_spr) / 2) + 8;
				
	if (_ix == _mgx && _iy == _mgy) {
		draw_set_alpha(.1);
		draw_rectangle(_x - _pad / 2, _y - _pad / 2 + 1, _x + _size + _pad / 2 - 2, _y + _size + _pad / 2 - 1, false);
		draw_set_alpha(1);
	}
	
	
	if (_ix == menu_selectx && _iy == menu_selecty) {
		draw_sprite_ext(_spr, 0, _dx + 1, _spy, 1, 1, 0, c_black, 1);	
		draw_sprite_ext(_spr, 0, _dx, _spy - 1, 1, 1, 0, c_black, 1);
		draw_sprite_ext(_spr, 0, _dx - 1, _spy, 1, 1, 0, c_black, 1);
		draw_sprite_ext(_spr, 0, _dx, _spy + 1, 1, 1, 0, c_black, 1);
	}
	
	draw_sprite(_spr, 0, _dx, _spy);	
}

var _midx = lerp(_c[0], _c[2], .75);

draw_text(_midx + menu_string_xoff, lerp(_c[1], _c[3], .31), menu_string);
draw_text(_midx - string_width(_item_price) / 2, lerp(_c[1], _c[3], .48), _item_price);