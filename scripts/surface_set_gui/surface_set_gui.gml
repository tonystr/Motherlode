/// @func surface_set_gui();

if (!surface_exists(obj_camera.gui_surf)) obj_camera.gui_surf = surface_create(obj_camera.width, obj_camera.height);

surface_set_target(obj_camera.gui_surf);