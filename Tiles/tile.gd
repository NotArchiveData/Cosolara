extends Node3D

@onready var shuffled_tiles = %shuffled_tiles
@onready var timer = %Timer

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
							var level = raycast.get_collider()
							var layer_ = raycast.get_parent()
							var category_ = layer_.get_parent()
							var um = str(category.name)

							if level.get_name() == "house_lv1":
								for name_ in category_.get_children():
									if name_.get_name() == "number":
										if str(global.die_sum) == name_.text:
											global.res[um] += randi_range(5, 15)
											global_signal.resources()
							
							elif level.get_name() == "house_lv2":
								for name_ in category_.get_children():
									if name_.get_name() == "number":
										if str(global.die_sum) == name_.text:
											global.res[um] += randi_range(25, 50)
											global_signal.resources()

				if layer.get_name() == "number":
					if str(global.die_sum) == layer.text && layer is Label3D:
						layer.set_modulate(Color( 0.587, 0.587, 0.587 ))
						timer.start()
						#for layer_ in tile.get_children():
							#if layer_ is MeshInstance3D:
								#pass

func _on_timer_timeout():
	# Revert the colour of the text on the tiles
	for category in shuffled_tiles.get_children():
		for tile in category.get_children():
			for layer in tile.get_children():
				if layer.get_name() == "number":
					if str(global.die_sum) == layer.text && layer is Label3D:
						layer.set_modulate(Color(0, 0, 0))
