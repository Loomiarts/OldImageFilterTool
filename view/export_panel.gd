extends PanelContainer

var _exported_image_index = -1


func _ready():
	var export_viewport = $VBoxContainer/ScrollContainer/ViewportContainer/Viewport
	$SelectExportFolderDialog.current_dir = "user://"
	$SelectExportFileDialog.current_dir = "user://"


func _on_ExportButton_pressed():
	if AppState.project.file_path != "":
		$SelectExportFolderDialog.current_dir = AppState.project.file_path.get_base_dir()
	$SelectExportFolderDialog.popup_centered()


func _on_ExportCurrentButton_pressed():
	if AppState.project.file_path != "":
		$SelectExportFileDialog.current_dir = AppState.project.file_path.get_base_dir()
	$SelectExportFileDialog.popup_centered()
	

func refresh_viewport():
	FilterUtils.render(AppState)
	if AppState.image != null and !AppState.image.is_empty():
		$VBoxContainer/ScrollContainer/ViewportContainer.rect_min_size = AppState.image.get_size()
		var image_texture = ImageTexture.new()
		image_texture.create_from_image(AppState.image)
		$VBoxContainer/ScrollContainer/ViewportContainer/Viewport/TextureRect.texture = image_texture
	else:
		$VBoxContainer/ScrollContainer/ViewportContainer.rect_min_size = Vector2(500, 500)
		$VBoxContainer/ScrollContainer/ViewportContainer/Viewport/TextureRect.texture = null


func _set_exporting_progress_visible(visible: bool):
	$VBoxContainer/Toolbar/ExportingLabel.visible = visible
	$VBoxContainer/Toolbar/ProgressBar.visible = visible


func _on_ExportImageDialog_dir_selected(dir):
	$ExportingDialog.set_progress_max_value(AppState.project.images.size())
	$ExportingDialog.set_progress_value(0)
	$ExportingDialog.popup_centered()
	_exported_image_index = -1
	call_deferred("_export_next_image", dir)


func _on_SelectExportFileDialog_file_selected(path):
	_save_current_render(path)


func _save_current_render(path: String):
	var render_viewport = $VBoxContainer/ScrollContainer/ViewportContainer/Viewport
	FilterUtils.render_export_image(AppState, render_viewport)
	ProjectUtils.export_image(AppState, path)


func _export_next_image(dir):
	_exported_image_index += 1
	ProjectUtils.select_image(AppState, _exported_image_index)
	refresh_viewport()
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	call_deferred("_finish_export_image", dir)


func _finish_export_image(dir):
	if AppState.image != null and !AppState.image.is_empty():
		_save_current_render(AppState.project.get_image(AppState.image_index).generate_output_path(dir))
	$ExportingDialog.set_progress_value(AppState.image_index + 1)
	if _exported_image_index < AppState.project.images.size() - 1:
		call_deferred("_export_next_image", dir)
	else:
		$ExportingDialog.hide()
