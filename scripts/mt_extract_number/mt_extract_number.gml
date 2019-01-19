/// @func mt_extract_number()
/*
if (mt_index == mt_recurrance) {
    mt_twist()
} else if (mt_index > mt_recurrance) {
	console_log("ERROR: mt_index:", mt_index);
    exit;// "Generator was never seeded"
    // Alternativel_y, seed with constant value; 5489 is used in reference C code[46]
}

var _y = mt_state[mt_index++];
_y = _y ^ ((_y >> mt_u) & mt_d);
_y = _y ^ ((_y << mt_s) & mt_b);
_y = _y ^ ((_y << mt_t) & mt_c);
_y = _y ^ (_y >> mt_l);

return _y & power(2, mt_word_size);