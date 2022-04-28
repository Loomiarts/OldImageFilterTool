extends Reference

# Settings and data of a project.
class_name Project

class ProjectArgs:
	var contrast = 1.0
	var color_adjustment_intensity = 1.0
	var grain_size = 0.15
	var grain_intensity_highlights = 0.4
	var grain_intensity_midtones = 0.7
	var grain_intensity_shadows = 0.5
	var grunge_size = 1.0
	var grunge_intensity = 0.18
	var paper_intensity = 1.0
	var paper_damage_intensity = 0.3

class ProjectImage:
	var args = ProjectArgs.new()
	var file_path = ""
	
	func generate_output_path(dir: String):
		var file_name = file_path.get_file()
		return dir.plus_file(file_name)


# Array of image metadata (path and args).
var images = []

# Path of the project file. This information is not saved.
var file_path = "" setget _set_file_path


# Adds the given image to the project with default args. The path
# may be converted to relative.
func add_image(path: String):
	path = _convert_image_path_to_relative(path)
	for existing_image in images:
		if existing_image.file_path == path:
			return
	var image = ProjectImage.new()
	image.file_path = path
	images.append(image)


# Removes the image at the given index if not out of range.
func remove_image(index: int):
	if index >= 0 and index < images.size():
		images.remove(index)


# Returns the metadata of the image at the given index, or default values
# if out of range.
func get_image(index: int) -> ProjectImage:
	if index >= 0 and index < images.size():
		return images[index]
	else:
		return ProjectImage.new()


# Returns the absolute path of the image at the given index.
func get_image_absolute_path(index: int) -> String:
	return _convert_image_path_to_absolute(get_image(index).file_path)


func _set_file_path(new_file_path):
	_make_all_paths_absolute()
	file_path = new_file_path
	_make_all_paths_relative()
	

# Converts this object to a JSON dictionary.
func to_json_dictionary() -> Dictionary:
	var images_array = []
	for image in images:
		images_array.append({
			"args": {
				"contrast": image.args.contrast,
				"color_adjustment_intensity": image.args.color_adjustment_intensity,
				"grain_size": image.args.grain_size,
				"grain_intensity_highlights": image.args.grain_intensity_highlights,
				"grain_intensity_midtones": image.args.grain_intensity_midtones,
				"grain_intensity_shadows": image.args.grain_intensity_shadows,
				"grunge_size": image.args.grunge_size,
				"grunge_intensity": image.args.grunge_intensity,
				"paper_intensity": image.args.paper_intensity,
				"paper_damage_intensity": image.args.paper_damage_intensity,
			},
			"file_path": image.file_path
		})
	return {
		"images": images_array,
	}


# Converts this object to a JSON string.
func to_json_string() -> String:
	var dictionary = to_json_dictionary()
	return to_json(dictionary)


# Loads the contents of this object from the given JSON dictionary.
func load_from_json_dictionary(json: Dictionary):
	var images_array = json.get("images", [])
	for image_dictionary in images_array:
		var image = ProjectImage.new()
		image.file_path = image_dictionary.get("file_path", "")
		var args_dictionary = image_dictionary.get("args", {})
		image.args.contrast = args_dictionary.get("contrast", image.args.contrast)
		image.args.color_adjustment_intensity = args_dictionary.get("color_adjustment_intensity", image.args.color_adjustment_intensity)
		image.args.grain_size = args_dictionary.get("grain_size", image.args.grain_size)
		image.args.grain_intensity_highlights = args_dictionary.get("grain_intensity_highlights", image.args.grain_intensity_highlights)
		image.args.grain_intensity_midtones = args_dictionary.get("grain_intensity_midtones", image.args.grain_intensity_midtones)
		image.args.grain_intensity_shadows = args_dictionary.get("grain_intensity_shadows", image.args.grain_intensity_shadows)
		image.args.grunge_size = args_dictionary.get("grunge_size", image.args.grunge_size)
		image.args.grunge_intensity = args_dictionary.get("grunge_intensity", image.args.grunge_intensity)
		image.args.paper_intensity = args_dictionary.get("paper_intensity", image.args.paper_intensity)
		image.args.paper_damage_intensity = args_dictionary.get("paper_damage_intensity", image.args.paper_damage_intensity)
		images.append(image)


# Loads the contents of this object from the given JSON string.
func load_from_json_string(json: String):
	var parsed_json = parse_json(json)
	if typeof(parsed_json) == TYPE_DICTIONARY:
		load_from_json_dictionary(parsed_json)


func _make_all_paths_absolute():
	for image in images:
		image.file_path = _convert_image_path_to_absolute(image.file_path)


func _make_all_paths_relative():
	for image in images:
		image.file_path = _convert_image_path_to_relative(image.file_path)


func _convert_image_path_to_relative(image_path: String) -> String:
	var project_base_dir = file_path.get_base_dir()
	if project_base_dir.length() > 0:
		if image_path.is_abs_path():
			if image_path.begins_with(project_base_dir):
				return image_path.substr(project_base_dir.length() + 1)
	return image_path


func _convert_image_path_to_absolute(image_path: String) -> String:
	var project_base_dir = file_path.get_base_dir()
	if image_path.is_rel_path() and project_base_dir.length() > 0:
		return project_base_dir.plus_file(image_path)
	else:
		return image_path
