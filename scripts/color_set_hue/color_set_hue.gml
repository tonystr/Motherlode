/// @func color_set_hue(color, hue);
/// @arg color	0 - 16581375	(#000000 - #ffffff)
/// @arg hue	0 - 255			(#00	 - #ff    )

return make_color_hsv(argument1, color_get_saturation(argument0), color_get_value(argument0));