/// @func textbox_remove()
/// @arg index

var i = argument0;
ds_list_delete(messages, i);
ds_list_delete(message_timer, i);
ds_list_delete(message_time, i);