// Inherit the parent event
event_inherited();

var _ores = obj_included.data[? "ores"];

for (var i = ds_list_size(_ores) - 1; i >= 0; --i) {
	var _ore = _ores[| i];
	var _name = _ore[? "name"];
	ore_sprite[i + 1]	= asset_get_index("spr_ore" + string_lower(_name));
	ore_name[i + 1]		= _name;
	ore_price[i + 1]	= _ore[? "price"];
}

ore_sprite[0]	= -1;
ore_name[0]		= -1;
ore_price[0]	= -1;