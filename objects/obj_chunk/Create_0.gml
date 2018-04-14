// if(live_call()) return live_enabled;
randomize();

grid_size = 32;

width	= room_width  div grid_size;
height	= room_height div grid_size;
grid	= ds_grid_create(width, height);

surf_width  = obj_camera.width;
surf_height = obj_camera.height;
surf = surface_create(surf_width, surf_height);

enum ORE {
	BRONZE,
	IRON,
	SILVER,
	GOLD
}

ore_sprite = [spr_bronze, spr_iron, spr_silver, spr_gold];
ore_name = ["Bronze", "Iron", "Silver", "Gold"];

for (var i = 0; i < width * height; i++) {
	var _in = (i <= width) || (irandom(5) != 5);
	if (_in) _in += (i > width) && irandom(7) == 7;
	if (_in > 1) {
		var _rand = random(1);
		if (_rand < (i div width + 2) / height) _in = 2;
		_rand = random(1 - _rand);
		if (_rand < (i div width) / height) _in = 3;
		_rand = random(1 - _rand);
		if (_rand < (i div width) / height) _in = 4;
		_rand = random(1 - _rand);
		if (_rand < (i div width) / height) _in = 5;
	}
	grid[# i % width, i div width] = _in;	
}

for (var i = 0; i < width * height; i++) {
	var _cell = grid[# i % width, i div width];
	if (_cell <= 0) {
		var _x = i % width;
		var _y = i div width;
		var _index = 0;
		_index += (_x + 1 < width)  && grid[# _x + 1, _y];
		_index += (_y + 1 < height) && grid[# _x, _y + 1];
		_index += (_x - 1 >= 0)		&& grid[# _x - 1, _y];
		_index += (_y - 1 <= 0)		&& grid[# _x, _y - 1];
		
		if (random(_index * _index) > 4) grid[# _x, _y] = 1;
	}
}