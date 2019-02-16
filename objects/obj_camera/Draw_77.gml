
if (!surface_exists(gui_surf)) gui_surf = surface_create(width, height);


surface_set_target(application_surface);
draw_surface_ext(gui_surf, 0, 0, zoom, zoom, 0, c_white, 1);
surface_reset_target();

//surface_set_target(appapp_surf);
//
//shader_set(shd_palette);
//
//var _tex = sprite_get_texture(spr_palette, 0);
//
//texture_set_stage(uni_palette_tex, _tex);
//
//var _uvs = texture_get_uvs(_tex);
//
//shader_set_uniform_f_array(uni_palette_uvs, _uvs);
//
//
//
//shader_reset();
//
//surface_reset_target();
//
//draw_surface_ext(appapp_surf, 0, 0, zoom, zoom, 0, c_white, 1);

//draw_surface_ext(application_surface, 0, 0, zoom, zoom, 0, c_white, 1);

surface_set_gui();
draw_clear_alpha(c_white, 0);
surface_reset_target();