// if(live_call()) return live_enabled;

step++;

key_xaxis = input(BUTTON.RIGHT) - input(BUTTON.LEFT);
key_yaxis = input(BUTTON.DOWN)  - input(BUTTON.UP);

fuel -= fuel_per_second * .1;

if (state_wait && !--state_wait) {
	if (state_wait_state != noone) state = state_wait_state;
	state_wait_state = noone;
}

for (var i = 0; i < 6; i++) {
	if (input(BUTTON.ITMFUELTANK + i, BTYPE.PRESSED)) {
		if (item[i]) {
			with (instance_create_layer(x, y, "Instances", obj_action_item)) {
				action  = i;
				creator = other;
			}

			if (i >= 2 && i <= 3 && state == state_player_drill) {
				state_end_player_drill(state_player_move);
				state_wait = room_speed * .1;
				
			} else if (i == 5) {
				
			}

			if (!--item[i]) textbox_add("You used your last " + string_lower(item_name[i]), -1, true);
		} else textbox_add("You have no " + string_lower(item_name[i]) + "s left", -1, true);
	}
}

script_execute(state); // state_player_move

if (state != state_player_death && (hull <= 0 || fuel <= 0)) state = state_player_death;

if (!shop_timer-- && input(BUTTON.BACK, BTYPE.PRESSED)) inv_visible ^= 1;

image_angle_draw = lerp(image_angle_draw, -key_xaxis * 16 * (key_yaxis < 0), .1);
image_xscale_draw += (image_xscale_target - image_xscale_draw) * .2;

if (hit_timer && !--hit_timer) {
	
}

//console_log("Attempting to connect to gamepad...");

var _gpnum = gamepad_get_device_count();
for (var i = 0; i < _gpnum; i++) {
	if (gamepad_is_connected(i)) {
		global.gamepad_id = i;
		//console_log("Connected to gamepad:", i)
	}
}

//if (global.gamepad_id == -1) console_log("Failed to connect to gamepad");
	