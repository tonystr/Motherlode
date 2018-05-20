/// @func color_set_value(color, value);
/// @arg color	0 - 16581375	(#000000 - #ffffff)
/// @arg value	0 - 255			(#00	 - #ff    )

return make_color_hsv(color_get_hue(argument0), color_get_saturation(argument0), argument1);