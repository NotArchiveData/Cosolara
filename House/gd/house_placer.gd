extends Node3D

@onready var placed_houses = %placed_houses
@onready var houses = %all_houses

var house = preload("res://House/tscn/placed_house.tscn").instantiate()
const HOVER = preload("res://House/colour/hover.tres")
const GREEN = preload("res://House/colour/green.tres")

func _on_area_3d_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			if global.res["brick"] >= 100 && global.res["wood"] >= 70 && global.res["coins"] >= 40:
				build_my_house()
				global.buy_house()
				queue_free()
				houses.hide()
				global.housebuttonpressed = 0
			
			else:
				print("no money")

func build_my_house():
	house.global_transform = global_transform
	placed_houses.add_child(house)

func mouse_entered():
	colour_change(HOVER)

func mouse_exited():
	colour_change(GREEN)

func colour_change(material):
	for mesh in get_children():
			if mesh.get_name() == "home" && mesh is MeshInstance3D:
				mesh.material_override = material
			
			elif mesh.get_name() == "mound" && mesh is MeshInstance3D:
				mesh.material_override = material
