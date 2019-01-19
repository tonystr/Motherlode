/// @func mt_set_seed()
/// @arg seed

/*
with (obj_world) {
	mt_index = mt_recurrance;
	mt_state[0] = argument0;
	for (var i = 1; i < mt_recurrance; i++) { // loop over each element
		mt_state[i] = (mt_f * (mt_state[i - 1] ^ (mt_state[i - 1] >> (mt_word_size - 2))) + i) & power(2, mt_word_size);
	}
	for (var i = 0; i < mt_recurrance; i++) { // loop over each element
		console_log("mt_state[", i, "]: ", mt_state[i]);
	}
}