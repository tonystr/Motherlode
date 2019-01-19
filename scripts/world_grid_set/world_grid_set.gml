/// @func world_grid_get(x, y, value)
/// @arg x
/// @arg y
/// @arg value

var _x = argument0;
var _y = argument1;

if (_y < 0) return;

with (obj_world) {
	var _chunk_x = floor(_x / chunk_width);
	var _chunk_y = floor(_y / chunk_height);
	
	var _chunk = world_get_chunk(_chunk_x, _chunk_y);
	var _grid = _chunk[? "grid"];
	_chunk[? "modified"] = true;
	_grid[# _x - floor(_x / chunk_width) * chunk_width, _y - floor(_y / chunk_height) * chunk_height] = argument2;
}
