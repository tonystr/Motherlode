/// @func json_load(file_path);
/// @arg {String} file_path

var _buffer = buffer_load(argument0);
var _string = buffer_read(_buffer, buffer_string);
buffer_delete(_buffer);
return json_decode(_string);