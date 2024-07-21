extends StaticBody3D

var upgraded_house = preload("res://House/tscn/upgraded_house.tscn").instantiate()

func _on_area_3d_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed == true:
			build_my_house()
			queue_free()

			global.upgrade_house()
			global.housebuttonpressed = 0
			
func build_my_house():
	upgraded_house.global_transform = global_transform
	get_parent().add_child(upgraded_house)
