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

global.gamepad_id = -1;
global.gampad_deadzone = .37;

global.input_list_key = ds_list_create();
global.input_list_gp  = ds_list_create();

for (var i = 0; i < BUTTON.COUNT; i++) {
	ds_list_add_list(global.input_list_key, ds_list_create());
	ds_list_add_list(global.input_list_gp,	ds_list_create());
	// ds_list_mark_as_list(input_list, i);
}

var _log = "";

_log += input_add(BUTTON.RIGHT,	[ord("D"), vk_right],					[gp_axislh, gp_padr]);
_log += input_add(BUTTON.UP,	[ord("W"), vk_up, vk_space, vk_shift],  [gp_axislv, gp_padu]);
_log += input_add(BUTTON.LEFT,	[ord("A"), vk_left],					[gp_axislh, gp_padl]);
_log += input_add(BUTTON.DOWN,	[ord("S"), vk_down],					[gp_axislv, gp_padd]);

_log += input_add(BUTTON.BACK,			[vk_escape, vk_tab, vk_backspace],  [gp_start]);
_log += input_add(BUTTON.SELECT,		[vk_enter, vk_space],				[gp_select]);
_log += input_add(BUTTON.COMMANDLINE,	[192 /* "`" */],					[]);

if (argument_count && argument[0]) return console_log(_log);