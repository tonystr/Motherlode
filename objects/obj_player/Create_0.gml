// if(live_call()) return live_enabled;

input_initialize();

noclip = false;
step = 0;

enum MODULE {
	PROPELLER,
	DRILL_X,
	DRILL_Y
}

module_xoffset	   = [			  0,			   10,					   0];
module_yoffset	   = [			-17,		       -9,					   1];
module_sprite	   = [spr_propeller,      spr_drill_x,			 spr_drill_y];
module_sprite_anim = [spr_propeller_anim, spr_drill_x_anim, spr_drill_y_anim];
module_prev		   = MODULE.DRILL_X;
module_active	   = MODULE.DRILL_X;
module_interp	   = 0;
// module_count	   = 3;

components = ds_map_create();

var _comp_list = obj_included.data[? "components"];
var _len = ds_list_size(_comp_list);

for (var i = 0; i < _len; i++) {
	
	var _comps = _comp_list[|  i];
	var _name  = _comps[? "name"];
	var _data  = _comps[? "data"];
	
	components[? _name] = _data[| 0];	
}

console_log("encoded components:", json_encode(components));

// comp_sprite = [spr_drill_stock, -1, spr_hull_stock, spr_treads_stock, spr_exhaust_stock];

item_name	= [];
// item_button = [];
item_price  = [];
item_sprite = [];

var _items = obj_included.data[? "items"];
for (var i = ds_list_size(_items) - 1; i >= 0; --i) {
	var _prop = _items[| i];
	
	item_name[i] = _prop[? "name"];
	var _keys = _prop[? "keybinds"];
	input_add(BUTTON.ITMFUELTANK + i, [ord(_keys[| 0])]);
	item_price[i] = _prop[? "price"];
	item_sprite[i] = asset_get_index("spr_item_" + _prop[? "type"]);
}

item = array_create(ds_list_size(_items), 16);
item_count = array_length_1d(item);

shop_timer   = false;
shop_entered = noone;

fuel = 60;
fuel_max = 60;
fuel_per_second = 1.1 / room_speed;

hull = 60;
hull_max = 60;

money = 0;

hit_timer = 0;
hit_time  = room_speed * .36;

xvel = 0;
yvel = 0;

xacc = 0;
yacc = 0;

key_xaxis = 0;
key_yaxis = 0;

spd  = 374 / room_speed;
grav = 488 / room_speed;

fric = 1.4 / room_speed;

image_xscale_draw = 1;
image_yscale_draw = 1;
image_angle_draw  = 0;
draw_surf = surface_create(64, 64);
image_xscale_target = image_xscale;

draw_menu = noone;

drill = 0;
drill_base_spd = 37 / room_speed;
drill_force = 1;
drill_spd = drill_base_spd * drill_force;
drill_dir = 0;
drilling = false;
drill_grid_x = -1;
drill_grid_y = -1;
drill_start_x = x;
drill_start_y = y;
drill_boundary = room_speed * .1;

menu_selectx = -1;
menu_selecty = -1;
menu_string  = "";
menu_string_xoff = 0;
menu_string_counter = 0;

inv_width  = 6;
inv_height = 3;
inv_slots  = inv_width * inv_height;
inv_slot_size = 32;
inv_visible = false;
inv = ds_grid_create(inv_width, inv_height);
inv_selectx = -1;
inv_selecty = -1;
inv_selectedx = -1;
inv_selectedy = -1;
inv_filled = 0;

ore_sprite = [-1, spr_bronze, spr_iron, spr_silver, spr_gold];
ore_name   = [-1, "Bronze",   "Iron",   "Silver",   "Gold"	];
ore_price  = [-1, 100,		  400,		900,		1300	];

enum ITEM {
	NONE,
	BRONZE,
	IRON,
	SILVER,
	GOLD,
	COUNT
}

state = state_player_move;
state_wait = 0;
state_wait_state = noone;

dir_last = 0;

camera_xoffset = 0;
camera_yoffset = 0;

death_timer = 0;

save_dir = -1;

var _lds = obj_included.load_player;
if (is_string(_lds)) { // Obvious
	save_dir = _lds;
	player_load(save_dir);
	console_log("player loaded savefile: ", save_dir);
} else if (_lds >= 0) { // Numbered save. Assume normal save format
	save_dir = SDF_CHAR + string(_lds);
	player_load(save_dir);
	console_log("player loaded numbered savefile: ", save_dir);
} else { // Write new save directory
	var i = 0;
	while (directory_exists(SDF_CHAR + string(i))) i++;

	save_dir = SDF_CHAR + string(i);
	directory_create(save_dir);
	console_log("player created new savefile: ", save_dir);
}

if (!directory_exists(save_dir)) show_error("Failed to load player savefile, \"" + string(save_dir) + "\" is not a valid directory | " + string(_lds), true);

player_save();