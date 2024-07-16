extends Node3D

@onready var shuffled_tiles = %shuffled_tiles

var brick = preload("res://Tiles/Elements/brick.tscn").instantiate()
var ore = preload("res://Tiles/Elements/ore.tscn").instantiate()
var wheat = preload("res://Tiles/Elements/wheat.tscn").instantiate()
var wood = preload("res://Tiles/Elements/wood.tscn").instantiate()
var wool = preload("res://Tiles/Elements/wool.tscn")

var resource_list = [ brick, ore, wheat, wood, wool ]
var random_index = randi() % resource_list.size()
var selected_resource = resource_list[random_index]

func _ready():
	for tile in get_children():
		var transform_ = tile.global_transform
		var wool_tile = wool.instantiate()

		wool_tile.global_transform = transform_
		shuffled_tiles.add_child(wool_tile)
		tile.queue_free()


#func replace_tile(resource, resource_name):
	#resource.global_transform = global_transform
	#for categories in shuffled_tiles.get_children():
		#if categories.get_name() == resource_name:
			#categories.add_child(resource)

func get_collisions():
	for tile in get_children():
		for layers in tile.get_children():
			if layers.get_name() == "Raycast":
				for raycast in layers.get_children():
					if raycast.is_colliding():
						print(tile)
		

	
