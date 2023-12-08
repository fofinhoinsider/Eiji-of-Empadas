extends Control

@export var stream: AudioStream

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Plataformas Eiji of Empadas.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://options_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()

