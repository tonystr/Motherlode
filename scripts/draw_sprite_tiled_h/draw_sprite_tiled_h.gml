/// @func draw_sprite_tiled_h
/// @arg spr,subimg,x,y,min_x,max_x
var _spr = argument0,
	_sub = argument1,
	_x	 = argument2,
	_y   = argument3,
	_min = argument4,
	_max = argument5,
	_sze = sprite_get_width(_spr),
	_itr = ceil(abs(_max - _min) / _sze);
	
_x %= _sze;
_min = floor(_min / _sze) * _sze;

for (var i = 0; i < _itr + 3; i++) {
	draw_sprite(_spr, _sub, _min + _x + _sze*(i - 1), _y);
}

//draw_sprite();