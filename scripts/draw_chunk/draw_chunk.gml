/// @func draw_chunk(chunk, grid_size x, y, x1, y1, x2, y2);
/// @arg chunk
/// @arg grid_size Tilesize
/// @arg x
/// @arg y
/// @arg x1
/// @arg y1
/// @arg x2
/// @arg y2

var _chunk = argument0;
var _grid_size = argument1;
var _xoff = argument2;
var _yoff = argument3;
var _x1 = argument4;
var _y1 = argument5;
var _x2 = argument6;
var _y2 = argument7;

var _grid = _chunk[? "grid"];

var _width  = ds_grid_width(_grid);
var _height = ds_grid_height(_grid);

var _cx = obj_camera.x - obj_camera.width / 2;
var _cy = obj_camera.y - obj_camera.height / 2;

for (var _y = _y1, _maxy = ds_grid_height(_grid); _y < _y2; _y++) {
	for (var _x = _x1, _maxx = ds_grid_width(_grid); _x < _x2; _x++) {
		var _index = 0;
		var _cell = _grid[# _x, _y];
		
		if (_x < _width - 1) _index |= (_grid[# _x + 1, _y] != 0) // right
		else {
			var _chy = _chunk[? "y"];
			var _nchunk = world_get_chunk(_chunk[? "x"] + 1, _chy);
			var _ngrid  = _nchunk[? "grid"];
			_index |= (_ngrid[# 0, _y] != 0);
		}
		if (_y > 0) _index |= (_grid[# _x, _y - 1] != 0) * 2 // above
		else {
			var _chy = _chunk[? "y"] - 1;
			if (_chy >= 0) {
				var _chx = _chunk[? "x"];
			
				var _nchunk = world_get_chunk(_chx, _chy);
				var _ngrid  = _nchunk[? "grid"];
				_index |= (_ngrid[# _x, _maxy - 1] != 0) * 2;
			}
		}
		if (_x > 0) _index |= (_grid[# _x - 1, _y] != 0) * 4 // left
		else {
			var _chy = _chunk[? "y"];
			var _nchunk = world_get_chunk(_chunk[? "x"] - 1, _chy);
			var _ngrid  = _nchunk[? "grid"];
			_index |= (_ngrid[# _maxx - 1, _y] != 0) * 4;
		}
		if (_y < _height - 1) _index |= (_grid[# _x, _y + 1] != 0) * 8 // below
		else {
			var _chx = _chunk[? "x"];
			var _nchunk = world_get_chunk(_chx, _chunk[? "y"] + 1);
			var _ngrid  = _nchunk[? "grid"];
			_index |= (_ngrid[# _x, 0] != 0) * 8;
		}
		
		if (_cell != 0) {
		
			var _gsz = _grid_size / 2;
			var _ind = [];
		
			_ind[0] = ((_index & (2+4)) == 0) * 1; // above, left
			_ind[1] = ((_index & (2+1)) == 0) * 2; // above, right
			_ind[2] = ((_index & (8+4)) == 0) * 3; // below, left
			_ind[3] = ((_index & (8+1)) == 0) * 4; // below. right
		
			if (_ind[0]) && ((_y > 0		  ) && (_x > 0	 	    )) _ind[0] = ((_grid[# _x - 1, _y - 1]) == 0) * 1; // above, left
			if (_ind[1]) && ((_x < _width  - 1) && (_y > 0	 	    )) _ind[1] = ((_grid[# _x + 1, _y - 1]) == 0) * 2; // above, right
			if (_ind[2]) && ((_x > 0		  ) && (_y < _height - 1)) _ind[2] = ((_grid[# _x - 1, _y + 1]) == 0) * 3; // below, left
			if (_ind[3]) && ((_y < _height - 1) && (_x < _width  - 1)) _ind[3] = ((_grid[# _x + 1, _y + 1]) == 0) * 4; // below. right
		
			draw_sprite_part(spr_mars_32_161, 0, ((_ind[0]) % 4) * _gsz, (_ind[0] div 4) * _gsz, _gsz, _gsz, _xoff + _x * _grid_size - _cx,		   _yoff + _y * _grid_size - _cy);
			draw_sprite_part(spr_mars_32_161, 0, ((_ind[1]) % 4) * _gsz, (_ind[1] div 4) * _gsz, _gsz, _gsz, _xoff + _x * _grid_size - _cx + _gsz, _yoff + _y * _grid_size - _cy);
			draw_sprite_part(spr_mars_32_161, 0, ((_ind[2]) % 4) * _gsz, (_ind[2] div 4) * _gsz, _gsz, _gsz, _xoff + _x * _grid_size - _cx,		   _yoff + _y * _grid_size - _cy + _gsz);
			draw_sprite_part(spr_mars_32_161, 0, ((_ind[3]) % 4) * _gsz, (_ind[3] div 4) * _gsz, _gsz, _gsz, _xoff + _x * _grid_size - _cx + _gsz, _yoff + _y * _grid_size - _cy + _gsz);
		
			//draw_sprite_part(spr_mars_32_tilesheet, 0, (_index % 4) * _grid_size, (_index div 4) * _grid_size, _grid_size, _grid_size, x + _x * _grid_size, y + _y * _grid_size);
	
		} else {
			
			var _gsz = _grid_size / 2;
			var _ind = [];
		
			_ind[0] = ((_index & (2+4)) == (2+4)) * 1 + 5; // above, left
			_ind[1] = ((_index & (2+1)) == (2+1)) * 2 + 5; // above, right
			_ind[2] = ((_index & (8+4)) == (8+4)) * 3 + 5; // below, left
			_ind[3] = ((_index & (8+1)) == (8+1)) * 4 + 5; // below. right
		
			draw_sprite_part(spr_mars_32_161, 0, ((_ind[0]) % 4) * _gsz, (_ind[0] div 4) * _gsz, _gsz, _gsz, _xoff + _x * _grid_size - _cx,		   _yoff + _y * _grid_size - _cy);
			draw_sprite_part(spr_mars_32_161, 0, ((_ind[1]) % 4) * _gsz, (_ind[1] div 4) * _gsz, _gsz, _gsz, _xoff + _x * _grid_size - _cx + _gsz, _yoff + _y * _grid_size - _cy);
			draw_sprite_part(spr_mars_32_161, 0, ((_ind[2]) % 4) * _gsz, (_ind[2] div 4) * _gsz, _gsz, _gsz, _xoff + _x * _grid_size - _cx,		   _yoff + _y * _grid_size - _cy + _gsz);
			draw_sprite_part(spr_mars_32_161, 0, ((_ind[3]) % 4) * _gsz, (_ind[3] div 4) * _gsz, _gsz, _gsz, _xoff + _x * _grid_size - _cx + _gsz, _yoff + _y * _grid_size - _cy + _gsz);
		}

		if (_cell >= 2) {
			draw_sprite(ore_sprite[_cell - 2], 0, _xoff + _x * _grid_size - _cx, _yoff + _y * _grid_size - _cy);	
		}
	}
}
	
gpu_set_blendmode(bm_subtract);
	with (obj_drill_hole) draw_sprite_ext(sprite_index, image_index, round(x - _cx), round(y - _cy), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
gpu_set_blendmode(bm_normal);

/*
draw_rectangle( _xoff + 0 * _grid_size - _cx - 1,
				_yoff + 0 * _grid_size - _cy - 1,
				_xoff + 7 * _grid_size - _cx + 1,
				_yoff + 7 * _grid_size - _cy + 1, true);