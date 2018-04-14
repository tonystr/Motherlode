/// @func input_initialize()

enum BUTTON {
	RIGHT,
	UP,
	LEFT,
	DOWN,
	BACK,
	SELECT,
	COUNT
}

enum BTYPE {
	HELD,
	PRESSED,
	RELEASED,
	COUNT
}

input_list = ds_list_create();

for (var i = 0; i < BUTTON.COUNT; i++) {
	ds_list_add(input_list, ds_list_create());
	// ds_list_mark_as_list(input_list, i);
}

input_add(BUTTON.RIGHT, ord("D"), vk_right);
input_add(BUTTON.UP,	ord("W"), vk_up, vk_space, vk_shift);
input_add(BUTTON.LEFT,	ord("A"), vk_left);
input_add(BUTTON.DOWN,	ord("S"), vk_down);
input_add(BUTTON.BACK,	vk_escape, vk_tab, vk_backspace);
input_add(BUTTON.SELECT,vk_enter, vk_space);