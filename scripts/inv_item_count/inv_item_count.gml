/// @func inv_item_count
/// @arg item

var _item  = argument0;
var _count = 0;

for (var i = 0; i < inv_width * inv_height; i++) 
	_count += inv[# i % inv_width, i div inv_width] == _item;

return _count;