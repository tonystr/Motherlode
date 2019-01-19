// if(live_call()) return live_enabled;

if (!instance_exists(creator)) action = -1;
var _explode = 0;

switch (action) {
	case -1: instance_destroy(); break;
	
	case IACT.FUEL:	
		textbox_add("Filled " + string(min(creator.fuel + 60, creator.fuel_max) - creator.hull) + "l jetfuel");
		creator.fuel = min(creator.fuel + 30, creator.fuel_max); 
	break;
	case IACT.REPAIR:	
		textbox_add("Restored " + string(min(creator.hull + 60, creator.hull_max) - creator.hull) + " hull");
		creator.hull = min(creator.hull + 60, creator.hull_max); 
	break;
	case IACT.PLASTIC: _explode = true; destroy = false; break;
	case IACT.DYNAMITE:	_explode = true; break;
	case IACT.QUANTUM:	
		with (creator) {
			x = random(room_width);
			y = random(192)-128;
			
			if (world_position_meeting()) {
				_explode = true;
				hull -= 50;
				other.x = x;
				other.y = y;
			}
		}
	break;
	case IACT.MATTER:
		creator.x = room_width * .46;
		creator.y = -32;
	break;
	
	default: instance_destroy(); break;	
}

if (_explode) {
	if (instance_exists(obj_world) && tick % explosion2_time == 0) {
		var _gs = obj_world.grid_size;
		var _cx = floor(x / _gs);
		var _cy = floor(y / _gs);
			
		for (var _y = (_cy - 1 - (tick > 0)); _y <= (_cy + 1 + (tick > 0)); _y++) {
			for (var _x = (_cx - 1 - (tick > 0)); _x <= (_cx + 1 + (tick > 0)); _x++) {
				if (world_grid_get(_x, _y) < 0) continue;
				world_grid_set(_x, _y, 0);
				
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
}

if (destroy) instance_destroy();

tick++;