extends Node3D

@onready var shuffled_tiles = %shuffled_tiles

const brick = preload("res://Tiles/Elements/brick.tscn")
const ore = preload("res://Tiles/Elements/ore.tscn")
const wheat = preload("res://Tiles/Elements/wheat.tscn")
const wood = preload("res://Tiles/Elements/wood.tscn")
const wool = preload("res://Tiles/Elements/wool.tscn")

var resource_list = [ brick, ore, wheat, wood, wool ]

func _ready():
	global_signal.roll.connect(get_collisions)
	
	for tile in get_children():
		var location = tile.global_transform
		resource_list.shuffle()
		var random_resource = resource_list[0]
		replace_tile(random_resource, location)
		tile.queue_free()
		
	randomize_tile_numbers()

func replace_tile(resource, location):
	var resource_tile = resource.instantiate()
	resource_tile.global_transform = location
	for category in shuffled_tiles.get_children():
		if category.get_name() == resource_tile.name:
			category.add_child(resource_tile)

func randomize_tile_numbers():
	for category in shuffled_tiles.get_children():
		for tile in category.get_children():
			for layer in tile.get_children():
				if layer.get_name() == "number" && layer is Label3D:
					var rng = randi_range(2, 12)
					layer.text = str(rng)

func get_collisions():
	for category in shuffled_tiles.get_children():
		for tile in category.get_children():
			for layer in tile.get_children():
				if layer.get_name() == "Raycast":
					for raycast in layer.get_children():
						if raycast.is_colliding():
							var layer_ = raycast.get_parent()
							var category_ = layer_.get_parent()
							for name_ in category_.get_children():
								if name_.get_name() == "number":
									if str(global.die_sum) == name_.text:
										var um = str(category.name)
										global.res[um] += 10
										global_signal.resources()



