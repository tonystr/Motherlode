/// @func grid_meeting(x, y, grid, grid_x, grid_y, grid_size)
/// @arg x
/// @arg y
/// @arg grid
/// @arg grid_x
/// @arg grid_y
/// @arg grid_size
var _x = x; x = argument0;
var _y = y; y = argument1;
var _grid = argument2;
var _gx	  = argument3;
var _gy	  = argument4;
var _size = argument5;
var _out  = 0;

_out |= grid_position_meeting(bbox_right, bbox_top,    _grid, _gx, _gy, _size);
_out |= grid_position_meeting(bbox_left,  bbox_top,    _grid, _gx, _gy, _size) * 2;
_out |= grid_position_meeting(bbox_left,  bbox_bottom, _grid, _gx, _gy, _size) * 4;
_out |= grid_position_meeting(bbox_right, bbox_bottom, _grid, _gx, _gy, _size) * 8;

x = _x;
y = _y;

return _out;