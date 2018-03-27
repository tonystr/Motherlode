/// @func state_player_move

var _xaxis = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _yaxis = keyboard_check(ord("S")) - keyboard_check(ord("W"));
var _dir   = point_direction(0, 0, _xaxis, _yaxis);

var _grav = (grav - yvel) * fric;

yvel += _grav;

if (_xaxis != 0 || _yaxis != 0) {
	xvel += (xacc + lengthdir_x(spd, _dir) - xvel) * fric;
	yvel += (yacc + lengthdir_y(spd + _grav / fric, _dir) * (_yaxis < 0) - yvel) * fric;

	if (_xaxis != 0) image_xscale_target = sign(_xaxis);
	
	// Change module
	if (_yaxis > 0 && module_active != MODULE.DRILL_Y) {
		module_prev = module_active;
		module_active = MODULE.DRILL_Y;
		module_interp = 0;
		
	} else if (_yaxis < 0 && module_active != MODULE.PROPELLER) {
		module_prev = module_active;
		module_active = MODULE.PROPELLER;
		module_interp = 0;
	}
} else {
	xvel -= xvel * fric;
}

if (_yaxis == 0 && module_active != MODULE.DRILL_X) {
	module_prev = module_active;
	module_active = MODULE.DRILL_X;
	module_interp = 0;
}

image_speed = abs(xvel);

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

if ((xvel == 0 && _xaxis != 0 && _yaxis == 0 && yvel == 0) || (yvel == 0 && _yaxis > 0 && _xaxis == 0)) {
	if (angle_difference(dir_last, _dir) < 28) {
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