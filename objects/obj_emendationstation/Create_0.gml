// Inherit the parent event
event_inherited();

menu_selectx = -1;
menu_selecty = -1;
menu_string  = "";
menu_string_xoff = 0;
menu_string_counter = 0;

var _items = obj_included.data[? "items"];
for (var i = ds_list_size(_items) - 1; i >= 0; --i) {
	var _prop = _items[| i];
	
	item_name[i] = _prop[? "name"];
	item_price[i] = _prop[? "price"];
	item_sprite[i] = asset_get_index("spr_item_" + _prop[? "type"]);
}

item_count = ds_list_size(_items);