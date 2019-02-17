
if (customer == noone || !instance_exists(customer)) exit;

var _c = boundary_coordinates;
var _pad = 4;
			
draw_set_color(boundary_color);
draw_rectangle(_c[0] - _pad, _c[1] - _pad, _c[2] + _pad, _c[3] + _pad, outline);
		
if (!outline) {
	_pad /= 2;
	draw_set_color($7027e5);
	draw_line_width(_c[0] - _pad, _c[1] - _pad, _c[0] - _pad, _c[3] + _pad, 1);
	draw_line_width(_c[0] - _pad, _c[1] - _pad, _c[2] + _pad, _c[1] - _pad, 1);
	draw_line_width(_c[2] + _pad, _c[1] - _pad, _c[2] + _pad, _c[3] + _pad, 1);
	draw_line_width(_c[0] - _pad, _c[3] + _pad, _c[2] + _pad, _c[3] + _pad, 1);
}

draw_set_color(c_white);