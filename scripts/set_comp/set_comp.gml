/// @func set_comp(component_key, component_ds[, instance]);
/// @arg component_key
/// @arg component_ds
/// @arg [instance]

if (argument_count > 2) {
	with(argument[2]) set_comp(argument[0], argument[1]);
} else {
	components[? argument[0]] = argument[1];
	console_log("setting component: ", argument[0], "to ds:", argument[1]);
}