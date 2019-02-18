/// @func input_add_key()
/// @arg button enum
/// @arg ord...

var _button = argument[0];
var _log	= "";
var _scrs = [input_add_key, input_add_gp];

for (var i = 1; i < argument_count; i++) {
	
	var _scr = _scrs[i - 1];
	var _arr = argument[i];
	
	var _args = [_button];
	array_copy(_args, 1, _arr, 0, array_len(_arr));
	
	_log += script_execute_array(_scr, _args);
}

return _log;