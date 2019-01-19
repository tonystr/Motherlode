
/*
var _mwc = mwc_random(++seed_counter % 300, seed_counter div 300);
console_log("input value: ", seed_counter, " output mwc:", _mwc);
avg += _mwc;
	
console_log("average mwc:", avg / seed_counter);
*/

var _cam_right	= floor(obj_camera.x + obj_camera.width  / 2);
var _cam_top	= floor(obj_camera.y - obj_camera.height / 2);
var _cam_left	= floor(obj_camera.x - obj_camera.width  / 2);
var _cam_bottom	= floor(obj_camera.y + obj_camera.height / 2);

var _chunk_right	= floor(_cam_right	/ (chunk_width  * grid_size));
var _chunk_top		= floor(_cam_top	/ (chunk_height * grid_size));
var _chunk_left		= floor(_cam_left	/ (chunk_width  * grid_size));
var _chunk_bottom	= floor(_cam_bottom	/ (chunk_height * grid_size));

if (!surface_exists(surface)) surface = surface_create(obj_camera.width, obj_camera.height);
surface_set_target(surface);
draw_clear_alpha(c_white, 0);

for (var _y = _chunk_top; _y <= _chunk_bottom; _y++) {
	if (_y < 0) continue;
	for (var _x = _chunk_left; _x <= _chunk_right; _x++) {
		var _chunk = world_get_chunk(_x, _y);
		var _rmx = _x * chunk_width  * grid_size;
		var _rmy = _y * chunk_height * grid_size;
		draw_chunk(_chunk, grid_size, _x * chunk_width * grid_size, _y * chunk_height * grid_size,
			max(floor((_cam_left - _rmx)   / (grid_size)), 0), 
			max(floor((_cam_top - _rmy)    / (grid_size)), 0), 
			min(floor((_cam_right - _rmx)  / (grid_size)) + 1, chunk_width), 
			min(floor((_cam_bottom - _rmy) / (grid_size)) + 1, chunk_height));
	}
}

surface_reset_target();

draw_surface(surface, obj_camera.x - obj_camera.width / 2, obj_camera.y  - obj_camera.height / 2);