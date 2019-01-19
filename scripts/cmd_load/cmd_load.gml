/// @func cmd_load(message, args);
/// @arg command
/// @arg _args

var _message = argument0;
var _args = argument1;

var _dir = _args[1];
if (_dir == string_digits(_dir)) _dir = SDF_WORLD + _dir;

var _clear = array_length_1d(_args) > 2 && 
	(_args[2] == string_digits(_args[2]) ? 
		real(_args[2]) : 
		string_lower(_args[2]) == "clear");

if (string_pos(SDF_CHAR, _dir) > 0) {
	console_log("CMD:", "load player");
	var _inst = instance_exists(obj_player) ? 
		obj_player.id : 
		instance_create_layer(x, y, "Instances", obj_player);
		
	with (_inst) player_load(_dir);
	return;
}

console_log("CMD:", "load world");

if (_clear) world_clear_save();
else world_save(true);
	
obj_included.load_world = _dir;
with (all) if (object_index != obj_included) instance_destroy();
room_goto(rm_init);