// Inherit the parent event
event_inherited();

menu_selectx = -1;
menu_selecty = -1;
menu_string  = "";
menu_string_xoff = 0;
menu_string_counter = 0;

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