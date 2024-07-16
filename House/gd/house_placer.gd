extends Node3D

@onready var placed_houses = %placed_houses
@onready var houses = %all_houses

var house = preload("res://House/tscn/placed_house.tscn").instantiate()

func _on_area_3d_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			build_my_house()
			queue_free()
			
			global.res["coins"] -= 20
			global.resources()
			
			houses.hide()
			global.housebuttonpressed = 0
			
func build_my_house():
	house.global_transform = global_transform
	placed_houses.add_child(house)
	
