// if(live_call()) return live_enabled;

if (instance_exists(obj_camera)) {
	
	y = -power(abs(obj_camera.y + obj_camera.y_offset), 1.3);
}