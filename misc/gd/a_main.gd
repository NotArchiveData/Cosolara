extends Node3D

@onready var pause_menu = $pause_menu
var paused = false

func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		pause()
		
func pause():
	if paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		pause_menu.hide()
		get_tree().paused = false

	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		pause_menu.show()
		
	paused = !paused
