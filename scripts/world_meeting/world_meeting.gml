/// @func world_meeting([x, y])
/// @arg [x
/// @arg y]

var _x = x; if (argument_count > 0) x = argument[0];
var _y = y; if (argument_count > 0) y = argument[1];
var _out  = 0;

var _chunk_width  = obj_world.chunk_width;
var _chunk_height = obj_world.chunk_height;
var _grid_size	  = obj_world.grid_size;

var _chunk_right  = floor(bbox_right  / (_chunk_width  * _grid_size));
var _chunk_top	  = floor(bbox_top	  / (_chunk_height * _grid_size));
var _chunk_left	  = floor(bbox_left	  / (_chunk_width  * _grid_size));
var _chunk_bottom = floor(bbox_bottom / (_chunk_height * _grid_size));

var _chunk_rt = world_get_chunk(_chunk_right, _chunk_top);
var _chunk_lt = world_get_chunk(_chunk_left,  _chunk_top);
var _chunk_lb = world_get_chunk(_chunk_left,  _chunk_bottom);
var _chunk_rb = world_get_chunk(_chunk_right, _chunk_bottom);


if (bbox_top > 0) {
	_out |= grid_position_meeting(bbox_right, bbox_top,    
			_chunk_rt[? "grid"], 
				_chunk_right * _chunk_width * _grid_size, 
				_chunk_top * _chunk_height * _grid_size, _grid_size);
	_out |= grid_position_meeting(bbox_left,  bbox_top,    
			_chunk_lt[? "grid"], 
				_chunk_left * _chunk_width * _grid_size, 
				_chunk_top * _chunk_height * _grid_size, _grid_size) * 2;
}
if (bbox_bottom > 0) {
	_out |= grid_position_meeting(bbox_left,  bbox_bottom, 
			_chunk_lb[? "grid"], 
				_chunk_left * _chunk_width * _grid_size, 
				_chunk_bottom * _chunk_height * _grid_size, _grid_size) * 4;
	_out |= grid_position_meeting(bbox_right, bbox_bottom, 
			_chunk_rb[? "grid"], 
				_chunk_right * _chunk_width * _grid_size, 
				_chunk_bottom * _chunk_height * _grid_size, _grid_size) * 8;
}

x = _x;
y = _y;

return _out;