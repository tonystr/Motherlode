// if(live_call()) return live_enabled;

global.input_active = true;

messages = ds_list_create();
message_timer = ds_list_create();
message_time = ds_list_create();

draw_set_font(global.font);
font_height = string_height("ASWD/6iagdiuTL");

time = font_height;

console_active = false;
console_active_time = 0;
console_string = "";
console_strings_sent = [];
console_text = "";
console_name = "TonyStr";

commands = ds_map_create();
commands[? "set"] = cmd_set;
commands[? "get"] = cmd_get;
commands[? "restart"] = cmd_restart;
commands[? "load"] = cmd_load;
commands[? "save"] = cmd_save;
commands[? "set_seed"] = cmd_set_seed;