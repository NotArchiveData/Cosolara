extends Button

@onready var roads = %all_roads

@onready var houses = %all_houses
@onready var placed_houses = %placed_houses

func _on_pressed():
	roads.hide()
	global.roadbuttonpressed = 0
	
	if global.housebuttonpressed == 0:
		
		if global.res["brick"] > 20 && global.res["wood"] > 20:
			global.housebuttonpressed = 1
			can_i_place_house()
			are_all_children_hidden()
			houses.show()
		
		else:
			print("Can't place more houses, resources missing")
	
	elif global.housebuttonpressed == 1:
		houses.hide()
		global.housebuttonpressed = 0

func can_i_place_house():
	if placed_houses.get_child_count() == 0:
		pass
		
	else:
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
		print("Can't place more houses, please build roads")
		houses.hide()
		global.housebuttonpressed = 0
