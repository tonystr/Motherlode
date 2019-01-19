if (instance_number(object_index) > 1) {
	instance_destroy();
	return;
}

data = -1;
load_player = -1;
load_world = -1;
set_seed = 0; // NOTE: values higher or lower will cause issues. See YAL conditional conversion bug
// Well, higher wouldn't be an issue, it'd just force the game to start at the same seed every time