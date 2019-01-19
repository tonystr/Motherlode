if (room == rm_init) {
	console_log("including files from data.json...");
	data = json_load("data.json");
	room_goto_next();
}