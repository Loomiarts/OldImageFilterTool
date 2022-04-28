extends HBoxContainer


export var max_value: float setget _set_max_value
export var arg_name: String setget _set_arg_name


func _ready():
	_refresh_views()


func _set_max_value(new_max_value):
	max_value = new_max_value
	_refresh_views()


func _set_arg_name(new_arg_name):
	arg_name = new_arg_name
	_refresh_views()


func _refresh_views():
	if $VBoxContainer/HSlider != null:
		$VBoxContainer/HSlider.max_value = max_value
	if $VBoxContainer/Label != null:
		$VBoxContainer/Label.text = arg_name
	if AppState.project != null:
		var args = AppState.project.get_image(AppState.image_index).args
		var arg_value = args.get(arg_name)
		if arg_value is float:
			$VBoxContainer/HSlider.value = arg_value


func _on_HSlider_value_changed(value):
	if AppState.project != null:
		var args = AppState.project.get_image(AppState.image_index).args
		args.set(arg_name, value)
		FilterUtils.render(AppState);


func _on_ResetButton_pressed():
	var default_args = Project.ProjectArgs.new()
	var arg_value = default_args.get(arg_name)
	if arg_value is float:
		$VBoxContainer/HSlider.value = arg_value


func refresh():
	_refresh_views()
