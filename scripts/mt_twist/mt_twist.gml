/// @func mt_twist()

/*
for (var i = 0; i < mt_recurrance - 1; i++) {
    var _x = (mt_state[i] & mt_upper_mask)
                + (mt_state[(i + 1) % mt_recurrance] & mt_lower_mask)
    var _xa = _x >> 1
    if ((_x % 2) != 0) { // lowest bit of x is 1
        _xa = _xa ^ mt_coeff;
    }
    mt_state[i] := mt_state[(i + mt_middle) % mt_recurrance] ^ _xa;
}

mt_index = 0;