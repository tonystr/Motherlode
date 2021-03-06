/// @func chunk_create(chx, chy)
/// @arg chx x coordinate of chunk in chunk coordinate context
/// @arg chy y coordinate of chunk in chunk coordinate context

var _chunk = ds_map_create();
var _cw	   = obj_world.chunk_width;
var _ch	   = obj_world.chunk_height;
var _grid  = ds_grid_create(_cw, _ch);
ds_grid_clear(_grid, 1);

var _x = argument0;
var _y = argument1;

var _rnd = ((_x == 0) ? ~0 : _x) * ((_y == 0) ? ~0 : _y);
var _rng = xorshiftalt(obj_world.seed, xorshift32(_rnd + sign(_rnd) * 2));
var _word_size = 9223372036854775808; // power(2, 63);

var _och = []; // ore chance
_och[ORE.BRONZE] = .93 - (_y / 256);
_och[ORE.IRON  ] = .96 - (_y / 256);
_och[ORE.SILVER] = .98 - (_y / 256);
_och[ORE.GOLD  ] = .99 - (_y / 256);

//console_log("Creating chunk with seed:", abs(_rng / _word_size));

for (var i = 0; i < _cw * _ch; i++) {
	_rng = xorshift32(_rng);
	var _rnd = abs(_rng / _word_size);
	
	//console_log("	Chunk next seed:", _rnd);
	if (_rnd > _och[0]) for (var j = 0; j < ORE.SIZE; j++) {
		_grid[# i % _cw, i div _cw] += _rnd > _och[j];
	}
}


if (_y == 0) {
	var _grid_size = obj_world.grid_size;
	with (par_store) {
		var _left  = (x - sprite_xoffset)  / _grid_size;
		var _right = (x - sprite_xoffset + sprite_width) / _grid_size;
		/* console_log(object_get_name(object_index) + ":", 
			_left / _cw,	// 4.31
			_x + _cw,		// 19
			_right / _cw,	// 4.38
			_x				// 3
		); */
		if (_left / _cw < _x + _cw && _right / _cw > _x) {
			for (var i = max(_left - _x * _cw, 0); i < min(_right - _x * _cw, _cw); i++) {
				_grid[# i, 0] = -1;	
			}
		}
	}
}

_chunk[? "x"] = _x;
_chunk[? "y"] = _y;
_chunk[? "grid"] = _grid;

return _chunk;