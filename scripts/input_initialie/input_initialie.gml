/// @func input_initialize(debug)
/// @arg debug bool flag

enum BUTTON {
	RIGHT,
	UP,
	LEFT,
	DOWN,
	BACK,
	SELECT,
	COMMANDLINE,
	ITMFUELTANK,
	ITMNANOBOTS,
	ITMDYNAMITE,
	ITMPLASTICEXPLOSIVE,
	ITMQUANTUMTP,
	ITMMATTERTSM,
	COUNT
}

enum BTYPE {
	HELD,
	PRESSED,
	RELEASED,
	COUNT
}

global.input_list = ds_list_create();

for (var i = 0; i < BUTTON.COUNT; i++) {
	ds_list_add(global.input_list, ds_list_create());
	// ds_list_mark_as_list(input_list, i);
}

var _log = "";

_log += input_add(BUTTON.RIGHT, ord("D"), vk_right);
_log += input_add(BUTTON.UP,	ord("W"), vk_up, vk_space, vk_shift);
_log += input_add(BUTTON.LEFT,	ord("A"), vk_left);
_log += input_add(BUTTON.DOWN,	ord("S"), vk_down);
_log += input_add(BUTTON.BACK,	vk_escape, vk_tab, vk_backspace);
_log += input_add(BUTTON.SELECT,vk_enter, vk_space);
_log += input_add(BUTTON.COMMANDLINE, 192); // [`]

if (true || argument_count && argument[0]) return console_log(_log);