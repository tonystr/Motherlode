// Inherit the parent event
event_inherited();

enum UPTYPE {
	AMETHYST,
	EMERALD,
	RUBY,
	GOLD,
	LASER,
	SIZE
};

tab = 0;

components = obj_included.data[? "components"];

menu_selectx = -1;
menu_selecty = -1;
menu_string  = "";
menu_string_xoff = 0;
menu_string_counter = 0;

hover_color = $e8f7d4;