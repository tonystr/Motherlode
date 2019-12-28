/// @func set_comp(component_key, component_ds[, instance]);
/// @arg component_key
/// @arg component_ds
/// @arg [instance]

var _key = argument[0];
var _ds  = argument[1];

if (argument_count > 2) {
	with (argument[2]) set_comp(_key, _ds);
	
} else {
	components[? _key] = _ds;
	console_log("setting component: ", _key, "to ds:", _ds);
	
	if (_key == "fueltank") {
		fuel_max = _ds[? "capacity"];
		fuel = fuel_max;
	}
}