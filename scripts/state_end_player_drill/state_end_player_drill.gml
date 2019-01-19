/// @func state_end_player_drill()
if (argument_count) state = argument[0];

drilling = false;

with (obj_drill_hole) if (destroy == DHD.DRILL) instance_destroy();