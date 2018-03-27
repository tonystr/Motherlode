/// @func grid_position_meeting();
/// @arg x
/// @arg y
/// @arg grid
/// @arg grid_x
/// @arg grid_y
/// @arg grid_size
var _x = argument0 - argument3; 
var _y = argument1 - argument4; 
var _grid = argument2;
var _size = argument5;

_x = floor(_x / _size);
_y = floor(_y / _size);

if (_x < 0 || _y < 0 || _x >= ds_grid_width(_grid) || _y >= ds_grid_height(_grid)) return 0;

return _grid[# _x, _y];