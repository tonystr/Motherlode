// if(live_call()) return live_enabled;

var _xaxis = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _yaxis = keyboard_check(ord("S")) - keyboard_check(ord("W"));

for (var i = 0; i < 6; i++) {
	if (keyboard_check_pressed(item_button[i])) {
		if (item[i]) {
			with(instance_create_layer(x, y, "Instances", obj_action_item)) {
				action  = i;
				creator = other;
			}
		
			if (!item[i]--) { // used last one
				if (!instance_exists(obj_textbox)) instance_create_depth(0,0,0,obj_textbox);
				ds_list_add(obj_textbox.messages, "You used your last " + string_lower(item_name[i]));
				obj_textbox.time -= obj_textbox.font_height;
			}
		} else {
			if (!instance_exists(obj_textbox)) instance_create_depth(0,0,0,obj_textbox);
			ds_list_add(obj_textbox.messages, "You have no " + string_lower(item_name[i]) + "s left");
			obj_textbox.time -= obj_textbox.font_height;
		}
	}
}

script_execute(state);

image_angle_draw = lerp(image_angle_draw, -_xaxis * 16 * (_yaxis < 0), .1);
image_xscale_draw += (image_xscale_target - image_xscale_draw) * .2;

fuel -= fuel_per_second;