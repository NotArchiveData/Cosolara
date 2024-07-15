extends Button

@onready var roads = %all_roads
@onready var houses = %all_houses

const GREEN = preload("res://House/green.tres")

func _on_pressed():
	roads.hide()
	global.roadbuttonpressed = 0
	
	if global.housebuttonpressed == 0:
		
		if global.water > 20 && global.coins > 10:
			global.housebuttonpressed = 1
			make_house_green()
			can_i_place_house()
			are_all_children_hidden()
			houses.show()
			

	
	elif global.housebuttonpressed == 1:
		houses.hide()
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
		house.hide()
		for house_layers in house.get_children():
			if house_layers.get_name() == "Raycast":
				for raycast in house_layers.get_children():
					if raycast.get_name() == "house" and raycast.is_colliding():
						house.hide()
						break
					
					elif raycast.get_name() == "road" and raycast.is_colliding():
						house.show()
						

func are_all_children_hidden():
	var visibility = 0
	
	for house in houses.get_children():
		if not house.is_visible():
			visibility += 1
	
	if visibility == houses.get_child_count():
		print("Can't place any house, please place roads")
		houses.hide()
		global.housebuttonpressed = 0
