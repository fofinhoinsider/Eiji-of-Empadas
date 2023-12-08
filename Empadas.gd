extends RichTextLabel

func _process(delta):
	var image_file = "res://Sunny-land-files/Sunny-land-assets-files/PNG/sprites/coxinha/coxinha-abrindo-olho-01.png"
	var image = Image.new()
	var error = image.load(image_file)
	if error == OK:
		var texture = ImageTexture.new()
		texture.create_from_image(image)
		add_image(texture)
