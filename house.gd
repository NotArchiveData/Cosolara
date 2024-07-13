extends Button

@onready var houses = %Houses

var green = preload("res://House/green.tres")
var is_pressed = 0

func model_green():
	var house_slot = houses.get_children()
	for i in house_slot:
		var children = i.get_children()
		
		for k in children:
			k.set_surface_override_material(0, green)
			k.set_surface_override_material(1, green)

func _on_pressed():
	
	if is_pressed == 0:
		model_green()
		houses.show()
		print("ur mom")
		is_pressed = 1
	
	elif is_pressed == 1:
		houses.hide()
		print("ur dad")
		is_pressed = 0
