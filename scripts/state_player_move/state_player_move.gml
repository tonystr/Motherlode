/// @func state_player_move

var _dir   = point_direction(0, 0, key_xaxis, key_yaxis);

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

if (instance_exists(obj_chunk) && grid_meeting(x + xvel, y, obj_chunk.grid, obj_chunk.x, obj_chunk.y, obj_chunk.grid_size)) {
	var _sgn = sign(xvel);
	while (!grid_meeting(x + _sgn, y, obj_chunk.grid, obj_chunk.x, obj_chunk.y, obj_chunk.grid_size)) {
		x += _sgn;
	}
	
	xacc = -xvel * fric / 8; 
	xvel = 0;
	
}
x += xvel;

if (instance_exists(obj_chunk) && grid_meeting(x, y + yvel, obj_chunk.grid, obj_chunk.x, obj_chunk.y, obj_chunk.grid_size)) {
	var _sgn = sign(yvel);
	while (!grid_meeting(x, y + _sgn, obj_chunk.grid, obj_chunk.x, obj_chunk.y, obj_chunk.grid_size)) {
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