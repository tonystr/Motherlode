/// @func inv_add()
/// @arg item enumeration

for (var _y = 0; _y < inv_height; _y++) {
	for (var _x = 0; _x < inv_width; _x++) {
		if (!inv[# _x, _y]) {
			inv[# _x, _y] = argument0;
			inv_filled++;
			return true;
		}
	}
}
return false;