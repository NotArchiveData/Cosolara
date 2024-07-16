extends Node3D

@onready var shuffled_tiles = %shuffled_tiles

const brick = preload("res://Tiles/Elements/brick.tscn")
const ore = preload("res://Tiles/Elements/ore.tscn")
const wheat = preload("res://Tiles/Elements/wheat.tscn")
const wood = preload("res://Tiles/Elements/wood.tscn")
const wool = preload("res://Tiles/Elements/wool.tscn")

var resource_list = [ brick, ore, wheat, wood, wool ]

func _ready():
	for tile in get_children():
		var location = tile.global_transform
		resource_list.shuffle()
		var random_resource = resource_list[0]
		var resource_name = random_resource.instantiate()
		replace_tile(random_resource, resource_name.name, location)
		
		tile.queue_free()

func replace_tile(resource, resource_name, location):
	var resource_tile = resource.instantiate()
	resource_tile.global_transform = location
	for category in shuffled_tiles.get_children():
		if category.get_name() == resource_name:
			category.add_child(resource_tile)

func get_collisions():
	for tile in get_children():
		for layers in tile.get_children():
			if layers.get_name() == "Raycast":
				for raycast in layers.get_children():
					if raycast.is_colliding():
						print(tile)
		

	
