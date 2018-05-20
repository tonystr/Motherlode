/// @func color_set_saturation(color, saturation);
/// @arg color		0 - 16581375	(#000000 - #ffffff)
/// @arg saturation	0 - 255			(#00	 - #ff    )

return make_color_hsv(color_get_hue(argument0), argument1, color_get_value(argument0));