/// @func world_position_meeting([x, y])
/// @arg [x
/// @arg y]

var _x = (argument_count > 0) ? argument[0] : x;
var _y = (argument_count > 0) ? argument[1] : y;
var _out = 0;

var _chunk_width  = obj_world.chunk_width;
var _chunk_height = obj_world.chunk_height;
var _grid_size	  = obj_world.grid_size;

var _chunk_x = _x div (_chunk_width  * _grid_size);
var _chunk_y = _y div (_chunk_height * _grid_size);
var _chunk = world_get_chunk(_chunk_x, _chunk_y);

return grid_position_meeting(_x, _y,    
	_chunk[? "grid"], 
	_chunk_x * _chunk_width * _grid_size, 
	_chunk_y * _chunk_height * _grid_size, 
	_grid_size);