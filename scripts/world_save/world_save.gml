/// @func world_save(clear)
/// @arg clear{Boolean} flag for clearing chunks after saving

with (obj_world) {
	for (var i = 0, _lcs = ds_list_size(loaded_chunks); i < _lcs; i++)
		chunk_save(loaded_chunks[| i]);

	if (argument_count > 0 && argument[0]) 
		ds_list_clear(loaded_chunks);	
}