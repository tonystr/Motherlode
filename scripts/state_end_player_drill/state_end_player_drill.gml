/// @func state_end_player_drill()
if (argument_count) state = argument[0];

drill_grid_x = -1;
drill_grid_y = -1;

with (obj_drill_hole) if (destroy == DHD.DRILL) instance_destroy();