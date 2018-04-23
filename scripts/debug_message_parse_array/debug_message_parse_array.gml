/// @func debug_message_parse_array
/// @arg array

var _arr = argument0;
var _len = array_length_1d(_arr);
var _str = "[";
var _com = false;
var _spa = false;

for(var i = 0; i < argument_count; i++) {
    var _val = argument[i];
    
    if (_com) _str += ",";
    if (_spa) _str += " ";
    
    _com = true;
    _spa = true;
    
    if (is_array(_val)) {
        _str += debug_message_parse_array(_val);

    } else if (is_string(_val)) {
        var _lastchr  = string_char_at(_val, string_length(_val));
        _com = (_lastchr == string_lettersdigits(_lastchr));
        _spa = (_lastchr != " ");
        
        _str += _val;
        
    } else {
        _str += string(_val);
    }
}

return _str + "]";
