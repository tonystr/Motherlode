// if(live_call()) return live_enabled;

action  = -1;
creator = noone;
destroy = true;

tick = 0;

explosion2_time = room_speed * .3;

enum IACT {
	FUEL,
	REPAIR,
	DYNAMITE,
	PLASTIC,
	QUANTUM,
	MATTER
}