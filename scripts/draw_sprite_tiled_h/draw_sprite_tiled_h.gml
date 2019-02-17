/// @func draw_sprite_tiled_h
/// @args spr,subimg,x,y,min_x,max_x

var _spr = argument0;
var _sub = argument1;
var _x	 = argument2;
var _y   = argument3;
var _min = argument4;
var _max = argument5;
var _sze = sprite_get_width(_spr);
var _itr = ceil(abs(_max - _min) / _sze);
	
_x %= _sze;
_min = floor(_min / _sze) * _sze;

for (var i = 0; i < _itr + 3; i++) {
	draw_sprite(_spr, _sub, _min + _x + _sze * (i - 1), _y);
}