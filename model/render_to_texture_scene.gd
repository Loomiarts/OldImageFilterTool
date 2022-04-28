extends Viewport


func _ready():
	var texture = ImageTexture.new()
	texture.create_from_image(AppState.image)
	$Sprite.texture = texture
