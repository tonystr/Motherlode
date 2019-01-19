/// @func cmd_save(message, args);
/// @arg command
/// @arg args

var _message = argument0;
var _args = argument1;

world_save(false);

with (obj_player) player_save();