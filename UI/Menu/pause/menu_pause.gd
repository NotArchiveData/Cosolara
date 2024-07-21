extends Control

@onready var game = $"../"

func resume():
	game.pause()
	
func quit():
	get_tree().quit()
