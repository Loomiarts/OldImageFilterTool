extends Node

var project: Project setget _set_project

var image_index = 0 setget _set_image_index

var image: Image

var material: Material

var image_to_export: Image

signal new_project_opened

signal new_image_selected


func _ready():
	material = preload("res://model/filter_material.tres")
	project = Project.new()


func _set_project(new_project):
	project = new_project
	emit_signal("new_project_opened")


func _set_image_index(new_image_index):
	image_index = new_image_index
	emit_signal("new_image_selected")
