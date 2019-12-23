// @func state_player_drill

if (!instance_exists(obj_world)) {
	console_log("End Drill State:", 2);
	state_end_player_drill(state_player_move);
	exit;
}

var _grid_size   = obj_world.grid_size;
var _yoff   = _grid_size/2.2;

if (!drilling) {
	
	var _x = floor((x	   + lengthdir_x(_grid_size / 2, drill_dir)) / _grid_size) * _grid_size + _grid_size / 2;
	var _y = floor((y - 12 + lengthdir_y(_grid_size / 2, drill_dir)) / _grid_size) * _grid_size + _grid_size / 2;
	
	drill_dir = point_direction(x, y - _yoff, _x, _y);
	
	drill_grid_x = _x / _grid_size;
	drill_grid_y = _y / _grid_size;
	
	if (drill_spd * (1 - (y / room_height) < (7 / room_speed)) || world_grid_get(floor(drill_grid_x), floor(drill_grid_y)) <= 0) {
		state_end_player_drill(state_player_move);
		exit;
	}
	
	drilling = true;
}

/*
if (drill_grid_x < 0 || 
	drill_grid_y < 0 || 
	drill_grid_x > _grid_width || 
	drill_grid_y > _grid_height) {
		
	state_end_player_drill(state_player_move);
	exit;	
}*/

fuel -= fuel_per_second * 2.8;

x += lengthdir_x(drill_spd * (1 - (y / room_height)), drill_dir);
y += lengthdir_y(drill_spd * (1 - (y / room_height)), drill_dir);

var _dist = point_distance(x, y, drill_grid_x * _grid_size, drill_grid_y * _grid_size + _yoff);

if (_dist % (32 / 4) < 1) {
	with (instance_create_layer(x, floor(y) - 13, "Effects", obj_drill_hole)) {
		image_angle = random(360);
		image_xscale = random(.3) + .7;
		image_yscale = random(.3) + .7;
		destroy = DHD.DRILL;
	}
}

if (_dist <= drill_spd) {
	
	var _cell = world_grid_get(floor(drill_grid_x), floor(drill_grid_y)) - 1;
	if (_cell > 0) { 
		var _did  = (!inv_add(_cell))
		var _name = string_lower(obj_world.ore_name[_cell - 1]);
		
		if (_did || inv_filled >= inv_slots) {
			textbox_add("Inventory Full!" + (_did ? " Destroyed " : " +1 ") + _name);
		} else {
			textbox_add("+1 " + _name);
		}
	}
	
	world_grid_set(floor(drill_grid_x), floor(drill_grid_y), 0);
	
	//chunk_save(world_get_chunk(floor(drill_grid_x) div obj_world.chunk_width, floor(drill_grid_y) div obj_world.chunk_height));
	
	state_end_player_drill(state_player_move);
	exit;
}

drill++;