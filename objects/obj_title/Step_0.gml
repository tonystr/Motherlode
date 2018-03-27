// if(live_call()) return live_enabled;

if (instance_exists(obj_camera)) {
	
	y = -power(abs(obj_camera.y + obj_camera.height/6), 1.3);
}