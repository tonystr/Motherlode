/// @func player_load(dir, [instance])
/// @arg dir
/// @arg [instance]

var _dir = argument[0] + "/player.sav";
var _inst = argument_count > 1 ? argument[1] : id;

console_log("BUFFER LOAD DIR:", _dir);

with (_inst) {
	
	var _buff = buffer_load(_dir);
	var _load = json_decode(buffer_read(_buff, buffer_string));
	buffer_delete(_buff);
	
	var _item = _load[? "item"];
	for (var i = 0, _ls = ds_list_size(_item); i < _ls; i++) {
		item[i] = _item[| i];
	}
	
	var _comp_sprite = _load[? "comp_sprite"];
	for (var i = 0, _ls = ds_list_size(_comp_sprite); i < _ls; i++) {
		var _cs = _comp_sprite[| i];
		comp_sprite[i] = is_string(_cs) ? asset_get_index(_cs) : _cs;
	}
	
	x = _load[? "x"];
	y = _load[? "y"];
	money = _load[? "money"];
	
	var _hull = _load[? "hull"];
	hull = _hull[? "integrity"];
	hull_max = _hull[? "max"];
	
	var _fuel = _load[? "fuel"];
	fuel = _fuel[? "integrity"];
	fuel_max = _fuel[? "max"];
	fuel_per_second = _fuel[? "per_second"];
	
	var _inv = _load[? "inv"];
	inv = base64_to_grid(_inv[? "grid"]);
	inv_filled = _inv[? "filled"];
	
	console_log("Loaded player_data");
	
	ds_map_destroy(_load);
}