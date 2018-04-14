// if(live_call()) return live_enabled;

if (instance_exists(obj_player)) {
	x += (obj_player.x - x + obj_player.camera_xoffset) * .1;	
	y += (obj_player.y - y + obj_player.camera_yoffset - y_offset) * .1;	
}

camera_set_view_pos(camera, x - width / 2, y - height / 2);