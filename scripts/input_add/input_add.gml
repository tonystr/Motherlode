/// @func input_add()
/// @arg button enum
/// @arg ord...

var _button = argument[0];
var _list	= global.input_list[| _button];
var _log	= "";

if (argument_count < 2) show_error("Not enough arguments provided: input_add", true);

for (var i = 1; i < argument_count; i++) {
	ds_list_add(_list, argument[i]);
	_log += "Added " + string(chr(argument[i])) + " to list:" + string(_button) + chr(10);
}

return _log;