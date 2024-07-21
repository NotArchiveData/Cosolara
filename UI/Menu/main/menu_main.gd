extends Control

func play():
	get_tree().change_scene_to_file("res://misc/tscn/main.tscn")
	
func options():
	pass

func quit():
	get_tree().quit()
