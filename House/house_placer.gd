extends Node3D

@onready var placed_houses = %placed_houses
@onready var houses = %all_houses

const HOVER = preload("res://House/hover.tres")
const HOUSE = preload("res://House/placed_house.tscn")

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			build_my_house()
			queue_free()
			
			houses.hide()
			global.housebuttonpressed = 0
			

func build_my_house():
	var house_instantiated = HOUSE.instantiate()
	house_instantiated.global_transform = global_transform
	placed_houses.add_child(house_instantiated)
			
	
