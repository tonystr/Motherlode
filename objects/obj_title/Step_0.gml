// if(live_call()) return live_enabled;

if (instance_exists(obj_camera)) {
	
	if (time <= 0) {
		yvel = -time;
	} else if (time >= room_speed*4.2) {
		yvel = -time + room_speed*4.2;
		if (time >= room_speed*5.5 && !rectangle_in_rectangle(
				bbox_left, bbox_top, bbox_right, bbox_bottom,
				obj_camera.x - obj_camera.width  / 2,
				obj_camera.y - obj_camera.height / 2,
				obj_camera.x + obj_camera.width	 / 2,
				obj_camera.y + obj_camera.height / 2)) {
			instance_destroy();
		}
	} else {
		yvel = 0;
	}
	time++;
	if (yvel != 0) y = -power(abs(yvel*.32), 2.3) + 16;
}