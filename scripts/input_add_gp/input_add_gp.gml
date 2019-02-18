/// @func input_add_gp()
/// @arg button enum
/// @arg ord...

var _button = argument[0];
var _blist	= global.input_list_gp[| _button];
var _log	= "";

for (var i = 1; i < argument_count; i++) {
	ds_list_add(_blist, argument[i]);
	_log += "Added " + string(chr(argument[i])) + " to list:" + string(_button) + chr(10);
}

return _log;