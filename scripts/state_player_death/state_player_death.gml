/// @func state_player_death

if (sprite_index != spr_explosion) {
	image_index  = 0;
	image_speed  = 1;
	sprite_index = spr_explosion;
	inv_visible = false;
}

death_timer++;