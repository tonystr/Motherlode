// if(live_call()) return live_enabled;

width  = 480;
height = 270;

zoom = 3;

camera = camera_create();
view_camera[0] = camera;

view_enabled = true;
view_visible[0] = true;

surface_resize(application_surface, width, height);
window_set_size(width * zoom, height * zoom);
display_set_gui_size(width, height);

camera_set_view_pos(camera, x, y);
camera_set_view_size(camera, width, height);

window_set_position((display_get_width() - width * zoom) / 2, (display_get_height() - height * zoom)  / 2);


depth_color  = [$4102d6, $0c131e, $000000, $754b29, $11090d];
depth_color_count = array_length_1d(depth_color);
depth_change = 700;

sky_color = [$8ad3ff, $bf7846, $f7b971, $471f16, $8c2a56, $000000];
sky_color_count = array_length_1d(sky_color);
sky_surf = surface_create(width, height);

bg_props = [];
bg_propx = [];
bg_propc = irandom(5);

for (var i = 0; i < bg_propc; i++) {
	bg_props[i] = spr_mars_rock;
	bg_propx[i] = irandom(width);
}

planet_angle = 12;
planet_angle_speed = .1 / room_speed;