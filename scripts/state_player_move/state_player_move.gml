/// @func state_player_move

var _dir = point_direction(0, 0, key_xaxis, key_yaxis);

var _grav = (grav - yvel) * fric;

yvel += _grav;

if (key_xaxis != 0 || key_yaxis != 0) {
	xvel += (xacc + lengthdir_x(spd, _dir) - xvel) * fric;
	var _min = 8;
	if (key_yaxis < 0) yvel += (yacc + lengthdir_y(spd + _grav / fric, _dir) - yvel) / (_min + inv_filled * 5 / room_speed) * _min * fric;

	if (key_xaxis != 0) image_xscale_target = sign(key_xaxis);
	
	// Change module
	if (key_yaxis > 0 && module_active != MODULE.DRILL_Y) {
		module_prev = module_active;
		module_active = MODULE.DRILL_Y;
		module_interp = 0;
		
	} else if (key_yaxis < 0 && module_active != MODULE.PROPELLER) {
		module_prev = module_active;
		module_active = MODULE.PROPELLER;
		module_interp = 0;
	}
} else {
	xvel -= xvel * fric;
}

if (key_yaxis == 0 && module_active != MODULE.DRILL_X) {
	module_prev = module_active;
	module_active = MODULE.DRILL_X;
	module_interp = 0;
}

image_speed = abs(xvel);

var _prev_xvel = xvel;
var _prev_yvel = yvel;

/*///////////////////////////////////////////////////////////////
var _cam_right	=  ceil(obj_camera.x + obj_camera.width  / 2);
var _cam_top	= floor(obj_camera.y - obj_camera.height / 2);
var _cam_left	= floor(obj_camera.x - obj_camera.width  / 2);
var _cam_bottom	=  ceil(obj_camera.y + obj_camera.height / 2);

_cam_right	=  ceil(_cam_right	div (chunk_width  * grid_size));
_cam_top	= floor(_cam_top	div (chunk_height * grid_size));
_cam_left	= floor(_cam_left	div (chunk_width  * grid_size));
_cam_bottom	=  ceil(_cam_bottom	div (chunk_height * grid_size));
/*///////////////////////////////////////////////////////////////

if (!noclip && instance_exists(obj_world) && world_meeting(x + xvel, y) != 0) {
	var _sgn = sign(xvel);
	while (world_meeting(x + _sgn, y) == 0) {
		x += _sgn;
	}
	
	xacc = -xvel * fric / 8; 
	xvel = 0;
	
}
x += xvel;

if (!noclip && instance_exists(obj_world) && world_meeting(x, y + yvel) != 0) {
	var _sgn = sign(yvel);
	while (world_meeting(x, y + _sgn) == 0) {
		y += _sgn;
	}
	
	yacc = -yvel * fric; 
	yvel = 0;
}
y += yvel;

if (yvel == 0) {
	xvel -= xvel * fric * 2;	
}

if (xvel == 0 && key_xaxis != 0 && key_yaxis == 0 && yvel == 0) 
|| (yvel == 0 && key_yaxis > 0 && key_xaxis == 0) {
	if (!state_wait && angle_difference(dir_last, _dir) < 28) {
		if (drill < drill_boundary) {
			drill++;
		} else {
			drill = 0;
			drill_dir = _dir;
			drill_start_x = x;
			drill_start_y = y;
			xvel = 0;
			yvel = 0;
			state = state_player_drill;
		}
	} else drill = 0;
} else drill = 0;

dir_last = _dir;

if (yvel == 0 && _prev_yvel != 0) {
	var _dis = _prev_yvel - yvel;
	
	if (_dis > 200 / room_speed) {
		hit_timer = hit_time;
		hull -= _dis * 4;
	}
}

if (place_meeting(x, y, par_store) && magnitude(xvel, yvel) < 160 / room_speed) {
	var _shop = instance_place(x, y, par_store);
	if (_shop != shop_entered) {
		
		shop_entered   = _shop;
		camera_xoffset = _shop.x - x;
		camera_yoffset = _shop.y - y;
		draw_menu = _shop.object_index;
		
		_shop.customer = id;
		
		state = state_player_shop;
		xvel = 0;
		yvel = 0;
	}
} else shop_entered = noone;