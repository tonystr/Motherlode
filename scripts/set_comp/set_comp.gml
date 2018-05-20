/// @func set_comp(component, sprite[, instance]);

if (argument_count > 2) with(argument[2]) set_comp(argument[0], argument[1]);

comp_sprite[argument[0]] = argument[1];