// if(live_call()) return live_enabled;

image_speed = 0;

enum MODULE {
	PROPELLER,
	DRILL_X,
	DRILL_Y
}

magnitude(2, 7);

input_initialie();

module_xoffset	   = [			  0,			   10,					   0];
module_yoffset	   = [			-17,		       -9,					   1];
module_sprite	   = [spr_propeller,      spr_drill_x,			 spr_drill_y];
module_sprite_anim = [spr_propeller_anim, spr_drill_x_anim, spr_drill_y_anim];
module_prev		   = MODULE.DRILL_X;
module_active	   = MODULE.DRILL_X;
module_interp	   = 0;
module_count	   = 3;

item_name	= [	"Reserve Fuel Tank",	// 0
				"Hull Repair Nanobot",  // 1
				"Dynamite",				// 2
				"Plastic Explosive",	// 3
				"Quantum Teleporter",	// 4
				"Matter Transmitter"];	// 5
item		= array_create(6, 16);
item_button = [ord("F"), ord("R"), ord("X"), ord("C"), ord("Q"), ord("M")];
item_price  = [	   3000,	 7500,	   2000,	 5000,	   4000,	10000];
item_sprite = [spr_item_fueltank, 
			   spr_item_nanobots, 
			   spr_item_dynamite, 
			   spr_item_plasticexplosive, 
			   spr_item_quantumtp, 
			   spr_item_mattertsm];
item_count  = array_length_1d(item);

shop_timer   = false;
shop_entered = noone;

fuel = 60;
fuel_max = 60;
fuel_per_second  = 0; // 1.1 / room_speed;

hull = 60;
hull_max = 60;

gui_surf = -1;

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
drill_spd = 37 / room_speed;
drill_dir = 0;
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

money = 0;

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