extends Node3D

@onready var placed_houses = %placed_houses

const HOUSE = preload("res://House/house.tscn")

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			build_my_house()
			self.queue_free()

func build_my_house():
	var house_instantiated = HOUSE.instantiate()
	house_instantiated.global_transform = self.global_transform
	placed_houses.add_child(house_instantiated)
