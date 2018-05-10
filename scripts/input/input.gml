/// @func input()
/// @arg button enum
/// @arg type* enum - pressed/held/released (default: held)

var _button = argument[0];
var _type   = argument_count > 1 ? argument[1] : BTYPE.HELD;
var _output = false;

var _list	= global.input_list[| _button];
var _size	= ds_list_size(_list);

for (var i = 0; i < _size; i++) {
	switch (_type) {
		case BTYPE.HELD:	 _output += keyboard_check(_list[| i]);				break;
		case BTYPE.PRESSED:  _output += keyboard_check_pressed(_list[| i]);		break;
		case BTYPE.RELEASED: _output += keyboard_check_released(_list[| i]);	break;
	}
}

// show_debug_message(_output);

return _output > 0;