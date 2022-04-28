extends WindowDialog


func set_progress_max_value(max_value):
	$MarginContainer/ProgressBar.max_value = max_value


func set_progress_value(value):
	$MarginContainer/ProgressBar.value = value
