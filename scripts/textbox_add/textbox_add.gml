/// @func textbox_add()
/// @arg message // string
/// @arg time* // default: fh*3 // -1 for default // real
/// @arg single* flag // only add if none exists before // bool

if (!instance_exists(obj_textbox)) instance_create_depth(0,0,0,obj_textbox);

var i = 0;
with(obj_textbox) {
	if (i++) instance_destroy();
	var _msg  = string(argument[0]);
	var _time = argument_count > 1 && argument[1] >= 0 ? argument[1] : room_speed * 1.4;
	var _size = ds_list_size(messages);
	
	if (_size && argument_count > 2 && argument[2]) {
		for (var i = 0; i < _size; i++) {
			if (messages[| i] == _msg) {
				textbox_remove(i--);
				_size--;
			}
		}
	}
	
	var _y = min(0, (_size ? message_timer[| _size - 1] : _time / 2) - _time / 2);
	
	ds_list_add(messages, _msg);
	ds_list_add(message_timer, _y);
	ds_list_add(message_time, _time);
}

return true;