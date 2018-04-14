// if(live_call()) return live_enabled;

if (ds_exists(messages, ds_type_list)) ds_list_destroy(messages);
if (ds_exists(message_time, ds_type_list)) ds_list_destroy(message_time);