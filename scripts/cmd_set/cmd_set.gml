/// @func cmd_set(message, args);
/// @arg command
/// @arg _args

var _message = argument0;
var _args = argument1;

var _value = _args[2] == string_digits(_args[2]) ? real(_args[2]) : _args[2];

var _variable = _args[1];

var _opb = string_pos("[", _variable);
if (_opb != 0) {
	var _clb = string_pos("]", _variable);
	var _val = string_copy(_variable, _opb + 1, _clb - _opb - 1);
	if (_val == string_digits(_val)) _val = real(_val);
	else {
		_val = variable_instance_get(obj_player.id, _val);
	}
	var _arr = variable_instance_get(obj_player.id, string_copy(_variable, 1, _opb - 1));
	console_log("CMD:", "array set:", string_copy(_variable, 1, _opb - 1), string_copy(_variable, _opb + 1, _clb - _opb - 1), _value);
	_arr[@ _val] = _value;
	return;
}

console_log("CMD:", "set", obj_player.id, _variable, _value)
variable_instance_set(obj_player.id, _variable, _value);