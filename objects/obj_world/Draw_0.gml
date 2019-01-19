
surface_set_gui();


var _xoff = obj_camera.width - 32 - (obj_camera.x / (chunk_width * grid_size)) * 4;
var _yoff = 18 - (obj_camera.y / (chunk_width * grid_size)) * 4;

var _lcc = ds_list_size(loaded_chunks);

for (var i = 0; i < _lcc; i++) {
	var _chunk = loaded_chunks[| i];
	
	draw_sprite(sprite56, _chunk[? "modified"], _xoff + _chunk[? "x"] * 4, _yoff + _chunk[? "y"] * 4);
}

/*draw_sprite(sprite56, 1,
	_xoff + floor(obj_camera.x / (chunk_width * grid_size)) * 4, 
	_yoff + floor(obj_camera.y / (chunk_width * grid_size)) * 4);*/
draw_sprite_ext(sprite56, 0,
	_xoff + (obj_camera.x / (chunk_width * grid_size)) * 4 - .5, 
	_yoff + (obj_camera.y / (chunk_width * grid_size)) * 4 - .5,
	.25, .25, 0, c_aqua, 1);
	
surface_reset_target();