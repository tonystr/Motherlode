// if(live_call()) return live_enabled;

if (!instance_exists(creator)) action = -1;

switch (action) {
	case -1: instance_destroy(); break;
	
	case IACT.FUEL:		
		creator.fuel = median(0, creator.fuel + 30, creator.fuel_max);
	break;
	case IACT.REPAIR:	break;
	case IACT.PLASTIC:	destroy = false;
	case IACT.DYNAMITE:	
		if (instance_exists(obj_chunk) && tick % explosion2_time == 0) {
			var _gs = obj_chunk.grid_size;
			var _cx = floor((x - obj_chunk.x) / _gs);
			var _cy = floor((y - obj_chunk.y) / _gs);
			var _gw = obj_chunk.width;
			var _gh = obj_chunk.height;
			var _grid = obj_chunk.grid;
			
			for (var _y = (_cy - 1 - (tick > 0)); _y <= (_cy + 1 + (tick > 0)); _y++) {
				for (var _x = (_cx - 1 - (tick > 0)); _x <= (_cx + 1 + (tick > 0)); _x++) {
					_grid[# median(_x, 0, _gw - 1), median(_y, 0, _gh - 1)] = 0;
					
					with (instance_create_layer(_x * _gs + _gs/2, _y * _gs + _gs/2, "Effects", obj_particle)) {
						sprite_index = spr_explosion;
					}
					
					with (instance_create_layer(_x * _gs + irandom(_gs), _y * _gs + irandom(_gs), "Effects", obj_drill_hole)) {
						image_angle = random(360);
						image_xscale = random(.3) + .7;
						image_yscale = random(.3) + .7;
						destroy = DHD.CAMERA;
					}
				}
			}
			
			if (tick >= explosion2_time) destroy = true;
		}
	break;
	case IACT.QUANTUM:	break;
	case IACT.MATTER:	break;
	
	default: instance_destroy(); break;	
}

if (destroy) instance_destroy();

tick++;