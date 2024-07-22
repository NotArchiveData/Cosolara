extends Node3D

@onready var placed_roads = %placed_roads
@onready var roads = %all_roads

var road = preload("res://Roads/tscn/placed_road.tscn").instantiate()
const HOVER = preload("res://House/colour/hover.tres")
const GREEN = preload("res://House/colour/green.tres")

func _on_click_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			if global.res["brick"] >= 100 && global.res["wood"] >= 70 && global.res["coins"] >= 40:
				build_my_road()
				global.buy_road()
				queue_free()
				roads.hide()
				global.roadbuttonpressed = 0
			
			else:
				print("no money")

func build_my_road():
	road.global_transform = global_transform
	placed_roads.add_child(road)

func mouse_entered():
	colour_change(HOVER)

func mouse_exited():
	colour_change(GREEN)

func colour_change(material):
	for mesh in get_children():
			if mesh.get_name() == "road" && mesh is MeshInstance3D:
				mesh.material_override = material
