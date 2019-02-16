/// @func comp_sprite(name)
/// @args name

var _comp = components[? argument0];
return asset_get_index("spr_" + argument0 + "_" + _comp[? "type"]);