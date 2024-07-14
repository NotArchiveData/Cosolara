extends Node3D

@onready var placed_houses = %placed_houses

const HOUSE = preload("res://House/house.tscn")

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			print("pressed left click")
			
			# Instance the house scene
			var house_instance = HOUSE.instantiate()
			# Optionally, set the position of the new house instance
			house_instance.global_transform = self.global_transform
			# Add the new house instance to the placed_houses node
			placed_houses.add_child(house_instance)
			self.queue_free()

func placed_house():
	pass
