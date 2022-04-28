extends Reference


class_name ProjectUtils


static func new_project(app_state: AppState):
	_clear_state(app_state)
	app_state.project = Project.new()
	app_state.image_index = 0


static func open_project(app_state: AppState, path: String):
	_clear_state(app_state)
	var file = File.new()
	if file.open(path, File.READ) == OK:
		var json = file.get_as_text()
		var new_opened_project = Project.new()
		new_opened_project.load_from_json_string(json)
		new_opened_project.file_path = path
		app_state.project = new_opened_project
		select_image(app_state, 0)
	file.close()
	

static func _clear_state(app_state: AppState):
	app_state.image = null
	app_state.image_to_export = null


static func save_project(app_state: AppState, path: String):
	var file = File.new()
	if file.open(path, File.WRITE) == OK:
		app_state.project.file_path = path
		file.store_string(app_state.project.to_json_string())
	file.close()


static func import_images(app_state: AppState, paths: PoolStringArray):
	for path in paths:
		app_state.project.add_image(path)
	select_image(app_state, app_state.project.images.size() - 1)


static func remove_image(app_state: AppState):
	app_state.project.remove_image(app_state.image_index)
	if app_state.image_index >= app_state.project.images.size():
		select_image(app_state, app_state.project.images.size() - 1)
	else:
		select_image(app_state, app_state.image_index)


static func reload_image(app_state: AppState):
	select_image(app_state, app_state.image_index)
	

static func export_image(app_state: AppState, path: String):
	if app_state.image_to_export != null:
		app_state.image_to_export.save_png(path)


static func select_image(app_state: AppState, index: int):
	var image = Image.new()
	var images = app_state.project.images
	if index >= 0 and index < images.size():
		var image_path = app_state.project.get_image_absolute_path(index)
		image.load(image_path)
	app_state.image = image
	app_state.image_index = index
