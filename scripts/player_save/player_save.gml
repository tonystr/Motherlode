/// @func player_save(dir, [instance])
/// @arg [dir]
/// @arg [instance]

console_log("player saving currently disabled");
return; // TODO: fix this

var _dir = argument_count > 0 ? argument[0] : save_dir + "/player.sav";
var _inst = argument_count > 1 ? argument[1] : id;

/*
with (_inst) {
	
	var _savecontent = "{";
	_savecontent += "\"item\":[";
	for (var i = 0, _its = array_length_1d(item); i < _its - 1; i++) {
		_savecontent += string(item[i]) + ",";	
	}
	_savecontent += string(item[i]) + "],\"comp_sprite\":[";
	for (var i = 0, _its = array_length_1d(comp_sprite); i < _its - 1; i++) {
		var _nam = sprite_get_name(comp_sprite(i));
		_savecontent += _nam == "<undefined>" ? "-1," : "\"" + _nam + "\",";
	}
	var _nam = sprite_get_name(comp_sprite(i));
	_savecontent += string(_nam == "<undefined>" ? "-1" : "\"" + _nam + "\"") + "],";
	//comp_sprite = [spr_drill_stock, -1, spr_hull_stock, spr_treads_stock, spr_exhaust_stock];
	_savecontent += "\"x\":\"" + string(x) + "\",";
	_savecontent += "\"y\":\"" + string(y) + "\",";
	_savecontent += "\"money\":\"" + string(money) + "\",";
	_savecontent += "\"hull\":{\"integrity\":" + string(hull) + ",\"max\":" + string(hull_max) + "},";
	_savecontent += "\"fuel\":{\"integrity\":" + string(fuel) + ",\"max\":" + string(fuel_max) + ",\"per_second\":" + string(fuel_per_second) + "},";
	_savecontent += "\"inv\":{\"filled\":" + string(inv_filled) + ",\"grid\":\"" + grid_to_base64(inv) + "\"}";

	_savecontent += "}"
	
	var _file = file_text_open_write(_dir);

	file_text_write_string(_file, _savecontent);
	file_text_close(_file);
	
	console_log("Saved player_data:", _savecontent);
}*/