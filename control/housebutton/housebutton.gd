extends Button

@onready var houses = %Houses

const GREEN = preload("res://House/green.tres")
const RED = preload("res://House/red.tres")

var is_pressed = 0

func model_green():
	var houseNode = houses.get_children()
	for i in houseNode:
		var meshes = i.get_children()
		
		for j in meshes:
			if j.get_name() in [ "home", "mound" ]:
				j.set_surface_override_material(0, GREEN)
				j.set_surface_override_material(1, GREEN)
			
func model_red_NOTDONE():
	var houseNode = houses.get_children()
	for i in houseNode:
		var meshes = i.get_children()
		
		for j in meshes:
			j.set_surface_override_material(0, RED)
			j.set_surface_override_material(1, RED)

func _on_pressed():
	
	if is_pressed == 0:
		
		if global.water > 20 and global.coins > 10:
			model_green()
			houses.show()
			print("ur mom")
			is_pressed = 1
		
		else:
			model_red_NOTDONE()
			houses.show()
			is_pressed = 1
	
	elif is_pressed == 1:
		houses.hide()
		print("ur dad")
		is_pressed = 0
