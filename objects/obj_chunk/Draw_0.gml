// if(live_call()) return live_enabled;

var _minx = 0;
var _miny = 0;
var _maxx = width;
var _maxy = height;

if (instance_exists(obj_camera)) {
	var _grid_size = grid_size;
	
	with (obj_camera) {
		_minx = clamp((x - width  / 2) div _grid_size,     0, _maxx);
		_miny = clamp((y - height / 2) div _grid_size,     0, _maxy);
		_maxx = clamp((x + width  / 2) div _grid_size + 1, 0, _maxx);
		_maxy = clamp((y + height / 2) div _grid_size + 1, 0, _maxy);
	}
}

for (var _y = _miny; _y < _maxy; _y++) {
	for (var _x = _minx; _x < _maxx; _x++) {
		var _index = 0;
		var _cell = grid[# _x, _y];
		
		_index |= ((_x < width  - 1) && grid[# _x + 1, _y]) * 1; // right
		_index |= ((_y > 0		   ) && grid[# _x, _y - 1]) * 2; // above
		_index |= ((_x > 0		   ) && grid[# _x - 1, _y]) * 4; // left
		_index |= ((_y < height - 1) && grid[# _x, _y + 1]) * 8; // below
	
		if (_cell) {
		
			var _gsz = grid_size / 2;
			var _ind = [];
		
			_ind[0] = ((_index & (2+4)) == 0) * 1; // above, left
			_ind[1] = ((_index & (2+1)) == 0) * 2; // above, right
			_ind[2] = ((_index & (8+4)) == 0) * 3; // below, left
			_ind[3] = ((_index & (8+1)) == 0) * 4; // below. right
		
			if (_ind[0]) && ((_y > 0		 ) && (_x > 0		  )) _ind[0] = ((grid[# _x - 1, _y - 1]) == 0) * 1; // above, left
			if (_ind[1]) && ((_x < width  - 1) && (_y > 0		  )) _ind[1] = ((grid[# _x + 1, _y - 1]) == 0) * 2; // above, right
			if (_ind[2]) && ((_x > 0		 ) && (_y < height - 1)) _ind[2] = ((grid[# _x - 1, _y + 1]) == 0) * 3; // below, left
			if (_ind[3]) && ((_y < height - 1) && (_x < width  - 1)) _ind[3] = ((grid[# _x + 1, _y + 1]) == 0) * 4; // below. right
		
			draw_sprite_part(spr_mars_32_161, 0, ((_ind[0]) % 4) * _gsz, (_ind[0] div 4) * _gsz, _gsz, _gsz, x + _x * grid_size, y + _y * grid_size);
			draw_sprite_part(spr_mars_32_161, 0, ((_ind[1]) % 4) * _gsz, (_ind[1] div 4) * _gsz, _gsz, _gsz, x + _x * grid_size + _gsz, y + _y * grid_size);
			draw_sprite_part(spr_mars_32_161, 0, ((_ind[2]) % 4) * _gsz, (_ind[2] div 4) * _gsz, _gsz, _gsz, x + _x * grid_size, y + _y * grid_size + _gsz);
			draw_sprite_part(spr_mars_32_161, 0, ((_ind[3]) % 4) * _gsz, (_ind[3] div 4) * _gsz, _gsz, _gsz, x + _x * grid_size + _gsz, y + _y * grid_size + _gsz);
		
			//draw_sprite_part(spr_mars_32_tilesheet, 0, (_index % 4) * grid_size, (_index div 4) * grid_size, grid_size, grid_size, x + _x * grid_size, y + _y * grid_size);
	
		} else {
			
			var _gsz = grid_size / 2;
			var _ind = [];
		
			_ind[0] = ((_index & (2+4)) == (2+4)) * 1 + 5; // above, left
			_ind[1] = ((_index & (2+1)) == (2+1)) * 2 + 5; // above, right
			_ind[2] = ((_index & (8+4)) == (8+4)) * 3 + 5; // below, left
			_ind[3] = ((_index & (8+1)) == (8+1)) * 4 + 5; // below. right
		
			draw_sprite_part(spr_mars_32_161, 0, ((_ind[0]) % 4) * _gsz, (_ind[0] div 4) * _gsz, _gsz, _gsz, x + _x * grid_size, y + _y * grid_size);
			draw_sprite_part(spr_mars_32_161, 0, ((_ind[1]) % 4) * _gsz, (_ind[1] div 4) * _gsz, _gsz, _gsz, x + _x * grid_size + _gsz, y + _y * grid_size);
			draw_sprite_part(spr_mars_32_161, 0, ((_ind[2]) % 4) * _gsz, (_ind[2] div 4) * _gsz, _gsz, _gsz, x + _x * grid_size, y + _y * grid_size + _gsz);
			draw_sprite_part(spr_mars_32_161, 0, ((_ind[3]) % 4) * _gsz, (_ind[3] div 4) * _gsz, _gsz, _gsz, x + _x * grid_size + _gsz, y + _y * grid_size + _gsz);
		}

		if (_cell >= 2) {
			draw_sprite(ore_sprite[_cell - 2], 0, x + _x * grid_size, y + _y * grid_size);	
		}
	}
}