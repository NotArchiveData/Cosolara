extends StaticBody3D

var upgraded_house = preload("res://House/tscn/upgraded_house.tscn").instantiate()

func _on_area_3d_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed == true:
			if global.res["brick"] >= 100 && global.res["wood"] >=100 && global.res["coins"] >= 80 && global.res["wheat"] >= 100 && global.res["wool"] >= 100:
				upgrade_my_house()
				global.upgrade_house()
				queue_free()
				global.housebuttonpressed = 0
			
			else:
				print("no money")
			
func upgrade_my_house():
	upgraded_house.global_transform = global_transform
	get_parent().add_child(upgraded_house)
