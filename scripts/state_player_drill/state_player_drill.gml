// @func state_player_drill

if (!instance_exists(obj_chunk)) {
	state = state_player_move;
	drill_grid_x = -1;
	drill_grid_y = -1;
	
	x = drill_start_x;
	y = drill_start_y;
	exit;
}

var _grid_size   = obj_chunk.grid_size;
var _grid_width  = obj_chunk.width;
var _grid_height = obj_chunk.height;
var _grid_x = obj_chunk.x;
var _grid_y = obj_chunk.y;
var _yoff   = _grid_size/2.2;

if (drill_grid_x < 0 || drill_grid_y < 0) {
	
	var _x = floor((x	   + lengthdir_x(_grid_size / 2, drill_dir) - _grid_x) / _grid_size) * _grid_size + _grid_size / 2;
	var _y = floor((y - 12 + lengthdir_y(_grid_size / 2, drill_dir) - _grid_y) / _grid_size) * _grid_size + _grid_size / 2;
	
	drill_dir = point_direction(x, y - _yoff, _x, _y);
	
	drill_grid_x = _x / _grid_size;
	drill_grid_y = _y / _grid_size;
	
	if (drill_spd * (1 - (y / room_height) < (7 / room_speed)) || obj_chunk.grid[# floor(drill_grid_x), floor(drill_grid_y)] <= 0) {
		state = state_player_move;
		drill_grid_x = -1;
		drill_grid_y = -1;
		exit;
	}
}

if (drill_grid_x < 0 || 
	drill_grid_y < 0 || 
	drill_grid_x > _grid_width || 
	drill_grid_y > _grid_height) {
		
	state = state_player_move;
	drill_grid_x = -1;
	drill_grid_y = -1;
	exit;	
}

x += lengthdir_x(drill_spd * (1 - (y / room_height)), drill_dir);
y += lengthdir_y(drill_spd * (1 - (y / room_height)), drill_dir);

if (point_distance(x - _grid_x, y - _grid_y, drill_grid_x * _grid_size, drill_grid_y * _grid_size + _yoff) <= drill_spd) {
	
	obj_chunk.grid[# floor(drill_grid_x), floor(drill_grid_y)] = 0;
	
	state = state_player_move;
	drill_grid_x = -1;
	drill_grid_y = -1;
	exit;
}

drill++;