extends Button

@onready var houses = %all_houses

const GREEN = preload("res://House/green.tres")

func _on_pressed():
	
	if global.housebuttonpressed == 0:
		
		if global.water > 20 && global.coins > 10:
			
			make_house_green()
			can_i_place_house()
			houses.show()

			print("ur mom")
			global.housebuttonpressed = 1

	
	elif global.housebuttonpressed == 1:
		houses.hide()
		print("ur dad")
		global.housebuttonpressed = 0

func make_house_green():
	var houseNode = houses.get_children()
	for i in houseNode:
		var meshes = i.get_children()

		for j in meshes:

			if j.get_name() in [ "home", "mound" ]:
				j.set_surface_override_material(0, GREEN)
				j.set_surface_override_material(1, GREEN)

func can_i_place_house():
	for house in houses.get_children(): 
		for house_layers in house.get_children():
			if house_layers.get_name() == "Raycast":
				for raycast in house_layers.get_children():
					if raycast.is_colliding():
						house.hide()
