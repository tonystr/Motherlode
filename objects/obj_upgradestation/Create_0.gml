// Inherit the parent event
event_inherited();

upgrade = [];

enum UPTYPE { AMETHYST, EMERALD, RUBY, GOLD, LASER, SIZE};

upgrade_create(COMP.DRILL, UPTYPE.AMETHYST, spr_drill_amethyst, "Amethyst Drill", 750);
upgrade_create(COMP.DRILL, UPTYPE.EMERALD, spr_drill_emerald, "Emerald Drill", 2000);
upgrade_create(COMP.DRILL, UPTYPE.RUBY, spr_drill_ruby, "Ruby Drill", 5000);
upgrade_create(COMP.DRILL, UPTYPE.GOLD, spr_drill_gold, "Gold Drill", 20000);
upgrade_create(COMP.DRILL, UPTYPE.LASER, spr_drill_laser, "Laser Drill", 100000);


menu_selectx = -1;
menu_selecty = -1;
menu_string  = "";
menu_string_xoff = 0;
menu_string_counter = 0;

hover_color = $e8f7d4;