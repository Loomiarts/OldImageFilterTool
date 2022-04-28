extends Control


func _ready():
	ProjectUtils.new_project(AppState)
	_add_arg_editor("contrast", 10.0)
	_add_arg_editor("color_adjustment_intensity")
	_add_arg_editor("grain_size", 10.0)
	_add_arg_editor("grain_intensity_shadows", 2.0)
	_add_arg_editor("grain_intensity_midtones", 2.0)
	_add_arg_editor("grain_intensity_highlights", 2.0)
	_add_arg_editor("grunge_size", 10.0)
	_add_arg_editor("grunge_intensity")
	_add_arg_editor("paper_intensity")
	_add_arg_editor("paper_damage_intensity")
	AppState.connect("new_project_opened", self, "_refresh_viewport")
	AppState.connect("new_project_opened", self, "_refresh_image_selector")
	AppState.connect("new_image_selected", self, "_refresh_viewport")
	$MainPanel/Tabs.set_tab_title(0, "Edit")
	$MainPanel/Tabs.set_tab_title(1, "Export")
	$MainPanel/Tabs.set_tab_title(2, "About")
	$MainPanel/ImportImageDialog.current_dir = "user://"
	$MainPanel/LoadProjectDialog.current_dir = "user://"
	$MainPanel/SaveProjectDialog.current_dir = "user://"
	_refresh_viewport()


func _add_arg_editor(name, max_value = 1.0):
	var settings_container = $MainPanel/Tabs/EditTab/SettingsMargin/SettingsContainer
	var arg_editor_scene = preload("res://view/arg_editor.tscn")
	var arg_editor_instance = arg_editor_scene.instance()
	settings_container.add_child(arg_editor_instance)
	arg_editor_instance.arg_name = name
	arg_editor_instance.max_value = max_value
	AppState.connect("new_project_opened", arg_editor_instance, "refresh")
	AppState.connect("new_image_selected", arg_editor_instance, "refresh")


func _refresh_viewport():
	var texture = ImageTexture.new()
	texture.create_from_image(AppState.image)
	var preview_image = $MainPanel/Tabs/EditTab/ViewportContainer/VBoxContainer/ViewportPanel/Viewport
	var input_image_path_label = $MainPanel/Tabs/EditTab/ViewportContainer/VBoxContainer/ImageFilePathLabel
	preview_image.texture = texture
	FilterUtils.render(AppState)


func _refresh_image_selector(refresh_selection = false):
	var selector = $MainPanel/Tabs/EditTab/ViewportContainer/VBoxContainer/HBoxContainer/ImageSelector
	selector.clear()
	for image in AppState.project.images:
		selector.add_item(image.file_path)
	if refresh_selection:
		selector.select(AppState.image_index)


func _on_Tabs_tab_selected(tab):
	if tab == 1:
		$MainPanel/Tabs/ExportPanel.refresh_viewport()


func _on_ImageSelector_item_selected(index):
	ProjectUtils.select_image(AppState, index)


func _on_RemoveImageButton_pressed():
	ProjectUtils.remove_image(AppState)
	_refresh_viewport()
	_refresh_image_selector(true)


func _on_ReloadImageButton_pressed():
	ProjectUtils.reload_image(AppState)
	_refresh_viewport()
	_refresh_image_selector(true)


func _on_ZoomFitButton_pressed():
	$MainPanel/Tabs/EditTab/ViewportContainer/VBoxContainer/ViewportPanel/Viewport.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED


func _on_ZoomRealButton_pressed():
	$MainPanel/Tabs/EditTab/ViewportContainer/VBoxContainer/ViewportPanel/Viewport.stretch_mode = TextureRect.STRETCH_KEEP


func _on_ImportImgButton_pressed():
	if AppState.project.file_path != "":
		$MainPanel/ImportImageDialog.current_dir = AppState.project.file_path.get_base_dir()
	$MainPanel/ImportImageDialog.popup_centered()


func _on_LoadProjButton_pressed():
	if AppState.project.file_path != "":
		$MainPanel/LoadProjectDialog.current_dir = AppState.project.file_path.get_base_dir()
	$MainPanel/LoadProjectDialog.popup_centered()


func _on_SaveProjButton_pressed():
	if AppState.project.file_path != "":
		$MainPanel/SaveProjectDialog.current_path = AppState.project.file_path
	$MainPanel/SaveProjectDialog.popup_centered()


func _on_NewProjButton_pressed():
	ProjectUtils.new_project(AppState)
	_refresh_viewport()
	_refresh_image_selector(true)


func _on_ImportImageDialog_files_selected(paths):
	ProjectUtils.import_images(AppState, paths)
	_refresh_viewport()
	_refresh_image_selector(true)


func _on_LoadProjectDialog_file_selected(path):
	ProjectUtils.open_project(AppState, path)
	_refresh_viewport()
	_refresh_image_selector(true)


func _on_SaveProjectDialog_file_selected(path):
	ProjectUtils.save_project(AppState, path)
