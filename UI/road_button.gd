extends Button

@onready var houses = %all_houses

@onready var roads = %all_roads
@onready var placed_roads = %placed_roads

func _on_pressed():
	houses.hide()
	global.housebuttonpressed = 0
	
	if global.roadbuttonpressed == 0:
		
		if global.water > 20 && global.coins > 10:
			global.roadbuttonpressed = 1
			
			can_i_place_road()
			are_all_children_hidden()
			roads.show()

	elif global.roadbuttonpressed == 1:
		roads.hide()
		global.roadbuttonpressed = 0

func can_i_place_road():
	for road in roads.get_children():
		road.hide()
		for road_layers in road.get_children():
			if road_layers.get_name() == "Raycast":
				for raycast in road_layers.get_children():
					if raycast.is_colliding():
						road.show()
						break

func are_all_children_hidden():
	var visibility = 0
	
	for road in roads.get_children():
		if not road.is_visible():
			visibility += 1
	
	if visibility == roads.get_child_count():
		print("Can't place more roads, please build houses")
		roads.hide()
		global.roadbuttonpressed = 0

