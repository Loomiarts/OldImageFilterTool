extends Reference


class_name FilterUtils


# Renders the current shader with the project settings.
static func render(app_state: AppState):
	var material = app_state.material
	var args = app_state.project.get_image(app_state.image_index).args
	if app_state.image != null:
		material.set_shader_param("image_size", app_state.image.get_size())
	material.set_shader_param("contrast", args.contrast)
	material.set_shader_param("color_adjustment_intensity", args.color_adjustment_intensity)
	material.set_shader_param("grain_size", args.grain_size)
	material.set_shader_param("grain_intensity_highlights", args.grain_intensity_highlights)
	material.set_shader_param("grain_intensity_midtones", args.grain_intensity_midtones)
	material.set_shader_param("grain_intensity_shadows", args.grain_intensity_shadows)
	material.set_shader_param("grunge_size", args.grunge_size)
	material.set_shader_param("grunge_intensity", args.grunge_intensity)
	material.set_shader_param("paper_intensity", args.paper_intensity)
	material.set_shader_param("paper_damage_intensity", args.paper_damage_intensity)


# Outputs to the image_to_export in the app_state the rendering in the given viewport.
static func render_export_image(app_state: AppState, viewport: Viewport):
	var render_texture = viewport.get_texture()
	var render_image = render_texture.get_data()
	render_image.flip_y()
	AppState.image_to_export = render_image
