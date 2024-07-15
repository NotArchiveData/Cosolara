extends Button

@onready var roads = %all_roads
@onready var placed_roads = %placed_roads

const GREEN = preload("res://House/green.tres")

func _on_pressed():
	
	if global.roadbuttonpressed == 0:
		
		if global.water > 20 && global.coins > 10:
			
			make_road_green()
			can_i_place_road()
			roads.show()

			print("ur mom")
			global.roadbuttonpressed = 1

	
	elif global.roadbuttonpressed == 1:
		roads.hide()
		print("ur dad")
		global.roadbuttonpressed = 0

func make_road_green():
	var roadNode = roads.get_children()
	for i in roadNode:
		var meshes = i.get_children()

		for j in meshes:

			if j.get_name() == "road":
				j.set_surface_override_material(0, GREEN)
				j.set_surface_override_material(1, GREEN)

func can_i_place_road():
	for road in roads.get_children():
		for road_layers in road.get_children():
			if road_layers.get_name() == "Raycast":
				for raycast in road_layers.get_children():
					if raycast.is_colliding():
						road.show()
						break

					elif not raycast.is_colliding():
						if placed_roads.get_child_count() == 0:
							break
						
						else:
							road.hide()

