// Inherit the parent event
event_inherited();

upgrade = array_create(COMP.SIZE);
upgrade_offx = array_create(COMP.SIZE);
upgrade_offy = array_create(COMP.SIZE);
upgrade_type = array_create(COMP.SIZE);

/*enum COMP {
	DRILL,
	PROPELLER,
	HULL,
	TREADS,
	EXHAUST,
	SIZE
}*/

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

/*
// DRILL
var _comp = _components[| 0];
var _data = _comp[? "data"];

for (var i = ds_list_size(_data) - 1; i >= 0; --i) {
	
	var _drill = _data[| i];
	var _type = _drill[? "type"];
	
	upgrade[COMP.DRILL, i] = _data[| i];
	upgrade_type[COMP.DRILL, i] = _type;
	upgrade_name[COMP.DRILL, i] = string_upper(string_char_at(_type, 1)) + string_copy(_type, 2, string_length(_type) - 1) + " Drill";
	upgrade_price[COMP.DRILL, i] = _drill[? "price"];
}
var _spr = upgrade[COMP.DRILL, 0];
upgrade_offx[COMP.DRILL] = sprite_get_xoffset(_spr) - sprite_get_width(_spr)  / 2;
upgrade_offy[COMP.DRILL] = sprite_get_yoffset(_spr) - sprite_get_height(_spr) / 2;

// HULL
var _comp = _components[| 1];
var _data = _comp[? "data"];

for (var i = ds_list_size(_data) - 1; i >= 0; --i) {
	
	var _drill = _data[| i];
	var _type = _drill[? "type"];
	
	upgrade[COMP.HULL, i] = asset_get_index("spr_hull_" + _type);
	upgrade_type[COMP.HULL, i] = _type;
	upgrade_name[COMP.HULL, i] = string_upper(string_char_at(_type, 1)) + string_copy(_type, 2, string_length(_type) - 1) + " Hull";
	upgrade_price[COMP.HULL, i] = _drill[? "price"];
}
var _spr = upgrade[COMP.HULL, 0];
upgrade_offx[COMP.HULL] = sprite_get_xoffset(_spr) - sprite_get_width(_spr)  / 2;
upgrade_offy[COMP.HULL] = sprite_get_yoffset(_spr) - sprite_get_height(_spr) / 2;

// TREADS
var _comp = _components[| 2];
var _data = _comp[? "data"];

for (var i = ds_list_size(_data) - 1; i >= 0; --i) {
	
	var _drill = _data[| i];
	var _type = _drill[? "type"];
	
	upgrade[COMP.TREADS, i] = asset_get_index("spr_treads_" + _type);
	upgrade_type[COMP.TREADS, i] = _type;
	upgrade_name[COMP.TREADS, i] = string_upper(string_char_at(_type, 1)) + string_copy(_type, 2, string_length(_type) - 1) + " Treads";
	upgrade_price[COMP.TREADS, i] = _drill[? "price"];
}
var _spr = upgrade[COMP.TREADS, 0];
upgrade_offx[COMP.TREADS] = sprite_get_xoffset(_spr) - sprite_get_width(_spr)  / 2;
upgrade_offy[COMP.TREADS] = sprite_get_yoffset(_spr) - sprite_get_height(_spr) / 2;
*/

menu_selectx = -1;
menu_selecty = -1;
menu_string  = "";
menu_string_xoff = 0;
menu_string_counter = 0;

hover_color = $e8f7d4;