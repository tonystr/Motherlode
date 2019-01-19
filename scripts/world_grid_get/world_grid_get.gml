/// @func world_grid_get(x, y)
/// @arg x
/// @arg y

var _x = argument0;
var _y = argument1;

if (_y < 0) return 0;

with (obj_world) {
	var _chunk_x = floor(_x / chunk_width);
	var _chunk_y = floor(_y / chunk_height);
	
	console_log("wg_get x:", _chunk_x, _x, "y:", _chunk_y, _y);
	
	var _chunk = world_get_chunk(_chunk_x, _chunk_y);
	var _grid = _chunk[? "grid"];
	return _grid[# _x - floor(_x / chunk_width) * chunk_width, _y - floor(_y / chunk_height) * chunk_height];
}
