extends WATTest

var proj: Project

func pre():
	proj = Project.new()


func test_to_json_dictionary():
	# given:
	proj.file_path = "filepath/should/not/be/saved"
	var image1 = Project.ProjectImage.new()
	image1.file_path = "image1.png"
	image1.args.contrast = 0.1
	image1.args.color_adjustment_intensity = 0.2
	image1.args.grain_size = 0.3
	image1.args.grain_intensity_highlights = 0.4
	image1.args.grain_intensity_midtones = 0.41
	image1.args.grain_intensity_shadows = 0.5
	image1.args.grunge_size = 0.6
	image1.args.grunge_intensity = 0.7
	image1.args.paper_intensity = 0.8
	image1.args.paper_damage_intensity = 0.9
	var image2 = Project.ProjectImage.new()
	image2.file_path = "image2.png"
	image2.args.contrast = 0.15
	image2.args.color_adjustment_intensity = 0.25
	image2.args.grain_size = 0.35
	image2.args.grain_intensity_highlights = 0.45
	image2.args.grain_intensity_midtones = 0.46
	image2.args.grain_intensity_shadows = 0.55
	image2.args.grunge_size = 0.65
	image2.args.grunge_intensity = 0.75
	image2.args.paper_intensity = 0.85
	image2.args.paper_damage_intensity = 0.95
	proj.images = [
		image1,
		image2
	]
	
	# when:
	var dictionary = proj.to_json_dictionary()
	
	# then:
	asserts.is_false(dictionary.has("file_path"))
	asserts.is_equal(dictionary["images"].size(), 2)
	asserts.is_equal(dictionary["images"][0]["file_path"], "image1.png")
	asserts.is_equal(dictionary["images"][0]["args"]["contrast"], 0.1)
	asserts.is_equal(dictionary["images"][0]["args"]["color_adjustment_intensity"], 0.2)
	asserts.is_equal(dictionary["images"][0]["args"]["grain_size"], 0.3)
	asserts.is_equal(dictionary["images"][0]["args"]["grain_intensity_highlights"], 0.4)
	asserts.is_equal(dictionary["images"][0]["args"]["grain_intensity_midtones"], 0.41)
	asserts.is_equal(dictionary["images"][0]["args"]["grain_intensity_shadows"], 0.5)
	asserts.is_equal(dictionary["images"][0]["args"]["grunge_size"], 0.6)
	asserts.is_equal(dictionary["images"][0]["args"]["grunge_intensity"], 0.7)
	asserts.is_equal(dictionary["images"][0]["args"]["paper_intensity"], 0.8)
	asserts.is_equal(dictionary["images"][0]["args"]["paper_damage_intensity"], 0.9)
	asserts.is_equal(dictionary["images"][1]["file_path"], "image2.png")
	asserts.is_equal(dictionary["images"][1]["args"]["contrast"], 0.15)
	asserts.is_equal(dictionary["images"][1]["args"]["color_adjustment_intensity"], 0.25)
	asserts.is_equal(dictionary["images"][1]["args"]["grain_size"], 0.35)
	asserts.is_equal(dictionary["images"][1]["args"]["grain_intensity_highlights"], 0.45)
	asserts.is_equal(dictionary["images"][1]["args"]["grain_intensity_midtones"], 0.46)
	asserts.is_equal(dictionary["images"][1]["args"]["grain_intensity_shadows"], 0.55)
	asserts.is_equal(dictionary["images"][1]["args"]["grunge_size"], 0.65)
	asserts.is_equal(dictionary["images"][1]["args"]["grunge_intensity"], 0.75)
	asserts.is_equal(dictionary["images"][1]["args"]["paper_intensity"], 0.85)
	asserts.is_equal(dictionary["images"][1]["args"]["paper_damage_intensity"], 0.95)


func test_from_json_dictionary():
	# given:
	var dictionary = {
		"file_path": "filepath/should/not/be/loaded",
		"images": [
			{
				"file_path": "image1.png",
				"args": {
					"contrast": 0.1,
					"color_adjustment_intensity": 0.2,
					"grain_size": 0.3,
					"grain_intensity_highlights": 0.4,
					"grain_intensity_midtones": 0.41,
					"grain_intensity_shadows": 0.5,
					"grunge_size": 0.6,
					"grunge_intensity": 0.7,
					"paper_intensity": 0.8,
					"paper_damage_intensity": 0.9,
				}
			},
			{
				"file_path": "image2.png",
				"args": {
					"contrast": 0.15,
					"color_adjustment_intensity": 0.25,
					"grain_size": 0.35,
					"grain_intensity_highlights": 0.45,
					"grain_intensity_midtones": 0.46,
					"grain_intensity_shadows": 0.55,
					"grunge_size": 0.65,
					"grunge_intensity": 0.75,
					"paper_intensity": 0.85,
					"paper_damage_intensity": 0.95,
				}
			},
		]
	}
	
	# when:
	proj.load_from_json_dictionary(dictionary)
	
	# then:
	asserts.is_equal(proj.file_path, "")
	asserts.is_equal(proj.images.size(), 2)
	asserts.is_equal(proj.images[0].file_path, "image1.png")
	asserts.is_equal(proj.images[0].args.contrast, 0.1)
	asserts.is_equal(proj.images[0].args.color_adjustment_intensity, 0.2)
	asserts.is_equal(proj.images[0].args.grain_size, 0.3)
	asserts.is_equal(proj.images[0].args.grain_intensity_highlights, 0.4)
	asserts.is_equal(proj.images[0].args.grain_intensity_shadows, 0.5)
	asserts.is_equal(proj.images[0].args.grunge_size, 0.6)
	asserts.is_equal(proj.images[0].args.grunge_intensity, 0.7)
	asserts.is_equal(proj.images[0].args.paper_intensity, 0.8)
	asserts.is_equal(proj.images[0].args.paper_damage_intensity, 0.9)
	asserts.is_equal(proj.images[1].file_path, "image2.png")
	asserts.is_equal(proj.images[1].args.contrast, 0.15)
	asserts.is_equal(proj.images[1].args.color_adjustment_intensity, 0.25)
	asserts.is_equal(proj.images[1].args.grain_size, 0.35)
	asserts.is_equal(proj.images[1].args.grain_intensity_highlights, 0.45)
	asserts.is_equal(proj.images[1].args.grain_intensity_shadows, 0.55)
	asserts.is_equal(proj.images[1].args.grunge_size, 0.65)
	asserts.is_equal(proj.images[1].args.grunge_intensity, 0.75)
	asserts.is_equal(proj.images[1].args.paper_intensity, 0.85)
	asserts.is_equal(proj.images[1].args.paper_damage_intensity, 0.95)


func test_should_add_image():
	# when:
	proj.add_image("image.png")
	proj.add_image("image2.png")
	
	# then:
	asserts.is_equal(proj.images.size(), 2)
	asserts.is_equal(proj.images[0].file_path, "image.png")
	asserts.is_equal(proj.images[0].args.contrast, 1.0)
	asserts.is_equal(proj.images[1].file_path, "image2.png")
	asserts.is_equal(proj.images[1].args.contrast, 1.0)


func test_should_add_image_converting_to_relative_path():
	# given:
	proj.file_path = "C:/MyProject/proj.oldfilter"
	
	# when:
	proj.add_image("C:/MyProject/image1.png")
	proj.add_image("C:/MyProject/Images/image2.png")
	
	# then:
	asserts.is_equal(proj.images[0].file_path, "image1.png")
	asserts.is_equal(proj.images[1].file_path, "Images/image2.png")


func test_should_add_image_not_converting_to_relative_path_if_project_doesnt_have_file_path():
	# given:
	proj.file_path = ""
	
	# when:
	proj.add_image("C:/MyProject/image1.png")
	proj.add_image("C:/MyProject/Images/image2.png")
	
	# then:
	asserts.is_equal(proj.images[0].file_path, "C:/MyProject/image1.png")
	asserts.is_equal(proj.images[1].file_path, "C:/MyProject/Images/image2.png")


func test_should_convert_image_paths_to_relative_when_set_project_file_path():
	# given:
	proj.file_path = ""
	proj.add_image("C:/MyProject/image1.png")
	proj.add_image("C:/MyProject/Images/image2.png")
	
	# when:
	proj.file_path = "C:/MyProject/myproj.oldfilter"
	
	# then:
	asserts.is_equal(proj.images[0].file_path, "image1.png")
	asserts.is_equal(proj.images[1].file_path, "Images/image2.png")


func test_should_not_convert_image_paths_to_relative_when_set_project_file_path_if_already_relative():
	# given:
	proj.file_path = ""
	proj.add_image("image1.png")
	proj.add_image("Images/image2.png")
	
	# when:
	proj.file_path = "C:/MyProject/myproj.oldfilter"
	
	# then:
	asserts.is_equal(proj.images[0].file_path, "image1.png")
	asserts.is_equal(proj.images[1].file_path, "Images/image2.png")


func test_should_convert_relative_image_paths_when_update_project_file_path():
	# given:
	proj.file_path = "C:/MyProject/AnotherFolder/myproj.oldfilter"
	proj.add_image("image1.png")
	proj.add_image("Images/image2.png")
	
	# when:
	proj.file_path = "C:/MyProject/myproj.oldfilter"
	
	# then:
	asserts.is_equal(proj.images[0].file_path, "AnotherFolder/image1.png")
	asserts.is_equal(proj.images[1].file_path, "AnotherFolder/Images/image2.png")


func test_should_convert_relative_image_paths_to_absolute_when_cant_resolve_relative_path():
	# given:
	proj.file_path = "C:/MyProject/myproj.oldfilter"
	proj.add_image("image1.png")
	proj.add_image("Images/image2.png")
	
	# when:
	proj.file_path = "C:/MyOtherProject/myproj.oldfilter"
	
	# then:
	asserts.is_equal(proj.images[0].file_path, "C:/MyProject/image1.png")
	asserts.is_equal(proj.images[1].file_path, "C:/MyProject/Images/image2.png")


func test_should_return_image_absolute_path():
	# given:
	proj.file_path = "C:/MyProject/myproj.oldfilter"
	proj.add_image("image1.png")
	proj.add_image("Images/image2.png")
	proj.add_image("C:/AnotherFolder/Images/image2.png")
	
	# then:
	asserts.is_equal(proj.get_image_absolute_path(0), "C:/MyProject/image1.png")
	asserts.is_equal(proj.get_image_absolute_path(1), "C:/MyProject/Images/image2.png")
	asserts.is_equal(proj.get_image_absolute_path(2), "C:/AnotherFolder/Images/image2.png")
