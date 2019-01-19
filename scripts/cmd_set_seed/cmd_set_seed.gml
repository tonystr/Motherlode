/// @func cmd_restart(message, args);
/// @arg command
/// @arg _args
/// @return any

var _message = argument0;
var _args = argument1;

var _seed = _args[1];

var _clear = !(array_length_1d(_args) > 2) || 
	(_args[2] == string_digits(_args[2]) ? 
		real(_args[2]) : 
		string_lower(_args[2]) == "clear" || 
		string_lower(_args[2]) != "save");

console_log("CMD:", "set_seed", _seed);
if (_clear) {
	world_clear_save();
	obj_included.set_seed = _seed;
	with (all) if (object_index != obj_included) instance_destroy();
	room_goto(rm_init);
} else {
	world_save(true);
	obj_included.set_seed = _seed;
	with (all) if (object_index != obj_included) instance_destroy();
	room_goto(rm_init);
}