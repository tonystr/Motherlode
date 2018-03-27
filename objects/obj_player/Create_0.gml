// if(live_call()) return live_enabled;

image_speed = 0;

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
module_count	   = 3;

item_name	= [	"Reserve Fuel Tank",	// 0
				"Hull Repair Nanobot",  // 1
				"Dynamite",				// 2
				"Plastic Explosive",	// 3
				"Quantum Teleporter",	// 4
				"Matter Transmitter"];	// 5
item		= [		 16,	   16,		 16,	   16,		 16,	   16];
item_button = [ord("F"), ord("R"), ord("X"), ord("C"), ord("Q"), ord("M")];

fuel = 60;
fuel_max = 60;
fuel_per_second  = 1 / room_speed;

xvel = 0;
yvel = 0;

xacc = 0;
yacc = 0;

spd  = 374 / room_speed;
grav = 488 / room_speed;

fric = 1.4 / room_speed;

image_xscale_draw = 1;
image_yscale_draw = 1;
image_angle_draw  = 0;
image_xscale_target = image_xscale;

drill = 0;
drill_spd = 37 / room_speed;
drill_dir = 0;
drill_grid_x = -1;
drill_grid_y = -1;
drill_start_x = x;
drill_start_y = y;
drill_boundary = room_speed * .1;

inv_width  = 6;
inv_height = 4;
inv_slots  = inv_width * inv_height - 4;
inv = ds_grid_create(inv_width, inv_height);
inv_selectx = -1;
inv_selecty = -1;
inv_selectedx = -1;
inv_selectedy = -1;

state = state_player_move;

dir_last = 0;

test_state = true;