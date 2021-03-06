/// @desc unload chunks

var _lcc = ds_list_size(loaded_chunks);
if (_lcc >= chunk_minload) {
	var _cam_right	= obj_camera.x + obj_camera.width  / 2;
	var _cam_top	= obj_camera.y - obj_camera.height / 2;
	var _cam_left	= obj_camera.x - obj_camera.width  / 2;
	var _cam_bottom	= obj_camera.y + obj_camera.height / 2;

	_cam_right	=  ceil(_cam_right	/ (chunk_width  * grid_size));
	_cam_top	= floor(_cam_top	/ (chunk_height * grid_size));
	_cam_left	= floor(_cam_left	/ (chunk_width  * grid_size));
	_cam_bottom	=  ceil(_cam_bottom	/ (chunk_height * grid_size));

	for (var i = 0; i < _lcc; i++) {
		var _chunk = loaded_chunks[| i];
		var _x = _chunk[? "x"];
		var _y = _chunk[? "y"];
	
		if ((_lcc >= chunk_maxload && (_x < _cam_left || _y < _cam_top || _x > _cam_right || _y > _cam_bottom)) || 
			_x < _cam_left - 1 || _y < _cam_top - 1 || _x > _cam_right + 1 || _y > _cam_bottom + 1) {
			chunk_save(_chunk);
			ds_list_delete(loaded_chunks, i--);
			_lcc--;
		} 
	}
}

alarm[0] = chunk_update_interval;