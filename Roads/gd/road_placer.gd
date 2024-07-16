extends Node3D

@onready var placed_roads = %placed_roads
@onready var roads = %all_roads

const ROAD = preload("res://Roads/tscn/placed_road.tscn")

func _on_click_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			build_my_road()
			queue_free()
			
			roads.hide()
			global.res["coins"] -= 10
			global.resources()
			global.roadbuttonpressed = 0

func build_my_road():
	var road_instantiated = ROAD.instantiate()
	road_instantiated.global_transform = global_transform
	placed_roads.add_child(road_instantiated)
