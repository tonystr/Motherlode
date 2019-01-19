
grid_size = 32;

surface = -1;

ore_sprite = [spr_bronze, spr_iron, spr_silver, spr_gold];
ore_name = ["Bronze", "Iron", "Silver", "Gold"];

chunk_update_interval = room_speed * 6;
chunk_minload = 2;
chunk_maxload = 9;
alarm[0] = chunk_update_interval;

enum ORE {
	BRONZE,
	IRON,
	SILVER,
	GOLD,
	SIZE
}

chunk_width  = 16;
chunk_height = 16;

loaded_chunks = ds_list_create();

seed = obj_included.set_seed != 0 ? obj_included.set_seed : irandom(power(2, 64) - 1) + 1;

save_dir = "ERROR_NO_SAVEDIR_SET";

var _lds = obj_included.load_world;

if (_lds < 0) { // Write new save directory
	var i = 0;
	while (directory_exists(SDF_WORLD + string(i))) i++;

	save_dir = SDF_WORLD + string(i);
	directory_create(save_dir);
	world_save_data();
	console_log("created new savefile: ", save_dir);
} else {
	if (is_string(_lds)) { // Obvious
		save_dir = _lds;
	} else if (_lds >= 0) { // Numbered save. Assume normal save format
		save_dir = SDF_WORLD + string(_lds);
	}
	var _data = world_load_data();
	console_log("loaded world save data into map index:", _data);
	seed = _data[? "seed"];
	ds_map_destroy(_data);
	console_log("loaded savefile: ", save_dir, _lds);
}

console_log("Game seed set to:", seed);

if (!directory_exists(save_dir)) show_error("Failed to load savefile, \"" + string(save_dir) + "\" is not a valid directory | " + string(_lds), true);

/*
var _avg = 0;
var _avgavg = 0;
var _avgmax = 0;
var _avgmin = 1;
var _num = 0;
var _word_size = power(2, 63);
var _size = 1000;
for (var _seed = 1; _seed <= _size; _seed++) {
	_num = 0;
	_avg = 0;
	repeat(_size) {
		_num = xorshiftalt(_seed, _num);
		_avg += abs(_num / _word_size);
		//console_log("Xorshift32 PRND:", abs(_num / _word_size));
	}
	_avg /= _size;
	_avgmin = min(_avg, _avgmin);
	_avgmax = max(_avg, _avgmax);
	_avgavg += _avg;
	console_log("XOR: average of seed ", _seed, ":", _avg);
}
console_log("================ XOR ALT TEST COMPLETE ================");
console_log("Max average:", _avgmax);
console_log("Min average:", _avgmin);
console_log("Average average:", _avgavg / _size);

/*/ /*/ Mersenne Twister 19937-64 /*/ /*/

mt_word_size	= 64;	// w (bits)
mt_recurrance	= 312;	// n
mt_middle		= 156;	// m (middle word, offset of recurrance relation)
mt_seperation	= 31;	// r 

mt_coeff = 3339036135935528528150; // coefficients of the rational normal form twist matrix

mt_u = 29;
mt_d = 1574122160956548404502;
mt_s = 17;
mt_b = 2099938434171495514134;
mt_t = 37;
mt_c = 4721785201858365620246;
mt_l = 43;

mt_f = 6364136223846793005;


// Create a length n array to store the state of the generator
mt_state_length = mt_recurrance;
mt_state = [];
mt_index = mt_recurrance + 1;
mt_lower_mask = (1 << mt_seperation) - 1;
mt_upper_mask = (~mt_lower_mask & power(2, mt_word_size));

// Initialize the generator from a seed
mt_set_seed(1234);

var _avg = 0;
var _rnd = xorshift32(1234);
var _word_size = 63;
repeat(1000) {
	_rnd = xorshift32(_rnd);
	_avg += abs(_rnd / power(2, _word_size));
	console_log("Xorshift32 PRND:", abs(_rnd / power(2, _word_size)));
}
console_log("average:", _avg / 1000);

/*
int[0..n-1] MT
int index := n+1
const int lower_mask = (1 << r) - 1 // That is, the binary number of r 1's
const int upper_mask = lowest w bits of (not lower_mask)

// Initialize the generator from a seed
function seed_mt(int seed) {
    index := n
    MT[0] := seed
    for i from 1 to (n - 1) { // loop over each element
        MT[i] := lowest w bits of (f * (MT[i-1] xor (MT[i-1] >> (w-2))) + i)
    }
}
*/
 
// Extract a tempered value based on MT[index]
// calling twist() every n numbers
// function mt_extract_number()

// Generate the next n values from the series x_i 
// function mt_twist() 



/*
var _cam_right	=  ceil(obj_camera.x + obj_camera.width  / 2);
var _cam_top	= floor(obj_camera.y - obj_camera.height / 2);
var _cam_left	= floor(obj_camera.x - obj_camera.width  / 2);
var _cam_bottom	=  ceil(obj_camera.y + obj_camera.height / 2);

_cam_right	=  ceil(_cam_right	/ (chunk_width  * grid_size));
_cam_top	= floor(_cam_top	/ (chunk_height * grid_size));
_cam_left	= floor(_cam_left	/ (chunk_width  * grid_size));
_cam_bottom	=  ceil(_cam_bottom	/ (chunk_height * grid_size));

/*
for (var _y = _cam_top; _y <= _cam_bottom; _y++) {
	if (_y < 0) continue;
	for (var _x = _cam_left; _x <= _cam_right; _x++) {
		ds_list_add(loaded_chunks, chunk_create(_x, _y));
	}
}

/*

chunk_grid_width  = room_width div (chunk_width * grid_size);
chunk_grid_height = room_height div (chunk_height * grid_size);
chunk_grid = ds_grid_create(chunk_grid_width, chunk_grid_height);

console_log(chunk_grid_width, chunk_grid_height, chunk_grid_width * chunk_grid_height);

for (var i = 0; i < chunk_grid_width * chunk_grid_height; i++) {
	chunk_grid[# i % chunk_grid_width, i div chunk_grid_width] = chunk_create();
}