
if (input(BUTTON.BACK, BTYPE.PRESSED) || !instance_exists(shop_entered)) {
	state = state_player_move;
	camera_xoffset = 0;
	camera_yoffset = 0;
	shop_entered.customer = noone;
	shop_timer = room_speed * .1;
	draw_menu  = noone;
}

