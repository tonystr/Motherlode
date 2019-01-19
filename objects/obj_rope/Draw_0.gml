
/*
var _dis = point_distance(x, y, obj_player.x, obj_player.y);
var _dir = point_direction(x, y, obj_player.x, obj_player.y);
	
var _overshoot = max(_dis - 100, 0);
var _ldx = lengthdir_x(_overshoot, _dir);
var _ldy = lengthdir_y(_overshoot, _dir);
//arm_move_to(obj_player.x + _ldx, obj_player.y + _ldy - 3, true);

draw_set_color($362a28);
draw_rectangle(	min(x, obj_player.x + _ldx) - 32, 
				min(y, obj_player.y + _ldy) - 64,
				max(x, obj_player.x + _ldx) + 32,
				max(y, obj_player.y + _ldy) + 64, false);
draw_set_color(c_aqua);
draw_rectangle(obj_player.bbox_left, obj_player.bbox_top, obj_player.bbox_right, obj_player.bbox_bottom, false);
draw_set_color(c_lime);
draw_line_dot(x, y, obj_player.x + _ldx, obj_player.y + _ldy, 4, 3);
draw_set_color(c_fuchsia);
draw_circle(obj_player.x + _ldx, obj_player.y + _ldy, 5, true);
draw_point(obj_player.x + _ldx, obj_player.y + _ldy);
draw_set_color(c_white);
*/

arm_draw();