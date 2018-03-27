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
			var _cx = (x - obj_chunk.x) div obj_chunk.grid_size;
			var _cy = (y - obj_chunk.y) div obj_chunk.grid_size;
			var _gw = obj_chunk.width;
			var _gh = obj_chunk.height;
			var _grid = obj_chunk.grid;
			
			for (var _y = max(_cy - 1 - (tick > 0), 0); _y <= min(_cy + 1 + (tick > 0), _gh - 1); _y++) {
				for (var _x = max(_cx - 1 - (tick > 0), 0); _x <= min(_cx + 1 + (tick > 0), _gw - 1); _x++) {
					_grid[# _x, _y] = 0;
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