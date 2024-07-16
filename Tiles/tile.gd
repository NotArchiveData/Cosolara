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
		replace_tile(random_resource, location)
		
		tile.queue_free()
	get_number()

func replace_tile(resource, location):
	var resource_tile = resource.instantiate()
	resource_tile.global_transform = location
	for category in shuffled_tiles.get_children():
		if category.get_name() == resource_tile.name:
			category.add_child(resource_tile)

func get_collisions():
	for tile in get_children():
		for layers in tile.get_children():
			if layers.get_name() == "Raycast":
				for raycast in layers.get_children():
					if raycast.is_colliding():
						print(tile)

func get_number():
	for category in shuffled_tiles.get_children():
		for tile in category.get_children():
			for layer in tile.get_children():
				if layer.get_name() == "number" && layer is Label3D:
					var rng = randi_range(2, 12)
					layer.text = str(rng)

	
