/// @func world_save_data()

with (obj_world) {
	var _file = file_text_open_write(save_dir + "/data.json");
	file_text_write_string(_file, "{\"seed\":" + string(seed) + "}");
	file_text_close(_file);
}