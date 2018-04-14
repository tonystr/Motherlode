/// @func console_log()
/// @arg message...

var _str = string(argument[0]);

if (argument_count > 1) {
	for (var i = 1; i < argument_count; i++) {
		_str += ", " + string(argument[i]);	
	}
}

show_debug_message(_str);