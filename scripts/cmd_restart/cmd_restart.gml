/// @func cmd_restart(message, args);
/// @arg command
/// @arg _args
/// @return any

var _message = argument0;
var _args = argument1;

var _clear = array_length_1d(_args) > 1 && 
	(_args[1] == string_digits(_args[1]) ? real(_args[1]) : string_lower(_args[1]) == "clear");

console_log("CMD:", "restart");
if (_clear) {
	world_clear_save();
	instance_destroy(all, true);
	room_goto(rm_init);
} else {
	world_save(true);
	if (instance_exists(obj_world)) obj_included.load_world = obj_world.save_dir;
	if (instance_exists(obj_player)) obj_included.load_player = obj_player.save_dir;
	with (all) if (object_index != obj_included) instance_destroy();
	room_goto(rm_init);
}