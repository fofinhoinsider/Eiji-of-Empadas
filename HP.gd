extends RichTextLabel

func _process(delta):
	clear()
	var t=Texture.new()
	if Game.Gold < 4:
		t=load("res://Sunny-land-files/Sunny-land-assets-files/PNG/sprites/Eiji Cabeça.png")
	else:
		t=load("res://Sunny-land-files/Sunny-land-assets-files/PNG/sprites/Eiji BC Cabeça.png")
	
	for i in range(Game.playerHP):
		add_image(t,35,70)
