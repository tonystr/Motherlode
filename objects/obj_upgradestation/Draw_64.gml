if (customer == noone || !instance_exists(customer)) exit;
event_inherited();

var _pad = 18;
var _gs = 14 + _pad;

for (var i = 0; i < UPTYPE.SIZE; i++) {
	draw_sprite(upgrade[UPGRADE.DRILL, i], 
				0, 
				_pad + boundary_coordinates[0] + (i % 3) * _gs, 
				_pad + boundary_coordinates[1] + (i div 3) * _gs);
}