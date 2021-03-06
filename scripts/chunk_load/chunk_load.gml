/// @func chunk_load(x,y)
/// @arg x,y

var _fname = obj_world.save_dir + "/" + string(argument0) + "_" + string(argument1) + ".chunk";
var _chunk;
if (!file_exists(_fname)) {
	_chunk = chunk_create(argument0, argument1);
} else {
	_chunk = json_load(_fname);
	_chunk[? "grid"] = base64_to_grid(_chunk[? "grid"]);
}
ds_list_add(obj_world.loaded_chunks, _chunk);
_chunk[? "modified"] = false;
return _chunk;