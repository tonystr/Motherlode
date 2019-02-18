/// @func input()
/// @arg button enum
/// @arg type* enum - pressed/held/released (default: held)

if (!global.input_active) return false;

var _button = argument[0];
var _type   = argument_count > 1 ? argument[1] : BTYPE.HELD;
var _output = false;

var _klist	= global.input_list_key[| _button];
var _glist	= global.input_list_gp[|  _button];
var _size	= ds_list_size(_klist);

for (var i = 0; i < _size; i++) {
	switch (_type) {
		case BTYPE.HELD:
			var _check = keyboard_check(_klist[| i]);
			
			var _gpval = _glist[| i];
			
			if (!_check && (_gpval == gp_axislh || _gpval == gp_axislv)) {
				_check = max(-gamepad_axis_value(global.gamepad_id, _gpval) * 
					((_button == BUTTON.LEFT || _button == BUTTON.UP) * 2 - 1), global.gampad_deadzone);
				if (_check == global.gampad_deadzone) _check = 0;
			}
			
			if (_output == 0) _output = _check;
			break;
		case BTYPE.PRESSED:  if (_output == 0) _output = keyboard_check_pressed(_klist[| i]);	break;
		case BTYPE.RELEASED: if (_output == 0) _output = keyboard_check_released(_klist[| i]);	break;
	}
}

// show_debug_message(_output);

return _output;