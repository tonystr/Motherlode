// Inherit the parent event
event_inherited();

upgrade = [];

enum UPGRADE { DRILL, SIZE };
enum UPTYPE { AMETHYST, EMERALD, RUBY, GOLD, LASER, SIZE};

upgrade[UPGRADE.DRILL, UPTYPE.AMETHYST] = spr_drill_x_amethyst;
upgrade[UPGRADE.DRILL, UPTYPE.EMERALD]	= spr_drill_x_emerald;
upgrade[UPGRADE.DRILL, UPTYPE.RUBY]		= spr_drill_x_ruby;
upgrade[UPGRADE.DRILL, UPTYPE.GOLD]		= spr_drill_x_gold;
upgrade[UPGRADE.DRILL, UPTYPE.LASER]	= spr_drill_x_laser;