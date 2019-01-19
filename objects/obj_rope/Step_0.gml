
if (instance_exists(target)) {
	var _dis = point_distance(x, y, target.x, target.y);
	
	// only changing arm length if it is not already the same length
	if (max(_dis, rope_length) != arm_length) arm_set_length(max(_dis, rope_length), 12);
	arm_move_to(target.x, target.y - 3, true);
	
	arm_apply_force(3, 270);
	
	var _overshoot = _dis - rope_length * .91;
	if (_overshoot > 0) {
		var _dir = point_direction(x, y, target.x, target.y);
		var _ldx = lengthdir_x(_overshoot, _dir);
		var _ldy = lengthdir_y(_overshoot, _dir);
		target.xvel -= _ldx * .0002 * room_speed;
		target.yvel -= _ldy * .0002 * room_speed;
		arm_move_to(target.x + _ldx, target.y + _ldy - 3, true);
	} else arm_move_to(target.x, target.y - 3, true);
} else {
	if (arm_length > rope_length) {
		arm_apply_force(3, 270);
		arm_set_length(max(lerp(arm_length, rope_length - .5, .1), rope_length), 12);
	}
	arm_move_towards(x, y + rope_length, point_distance(x, y, x, y + rope_length) / 10, true);
}
