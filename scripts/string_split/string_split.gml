/// @func string_split(string, char[, allow_empty]);
/// @arg string
/// @arg char
/// @arg [allow_empty]

var _arr = [];
var _arr_pos = 0;
var _str = argument[0];
var _str_pos = 1;
var _str_len = string_length(_str);
var _chr = argument[1];
var _chr_len = string_length(_chr);
var _match_pos = 1;
var _match = "";
var _emptallowed = (argument_count > 2) && argument[2];

for (var i = 0; i < _str_len; ++i) {
	
	var _ichr = string_char_at(_str, i);
	
	if (string_char_at(_chr, _match_pos) == _ichr) {
		_match += _ichr;
		if (_match_pos++ >= _chr_len) {
			var _tmp = string_copy(_str, _str_pos, i - _str_pos);
			if (_emptallowed || _tmp != "") _arr[_arr_pos++] = _tmp;
			_match_pos = 1;
			_str_pos = i + 1;
		}
	} else _match_pos = 1;
}

_arr[_arr_pos++] = string_copy(_str, _str_pos, ++i - _str_pos);

return _arr;