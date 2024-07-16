extends Node

var distributed_tile_list = []
var ctr = 0
var rng_module = RandomNumberGenerator.new()

func _ready():
	get_collisions()
	#var children = get_child_count()
	#rng_module.randomize()
	#
	#var lower_limit = int(children * 0.18)
	#var upper_limit = int(children * 0.22)
		#
	#for i in range(4):
		#var rng = randi_range(lower_limit, upper_limit)
		#ctr += rng
		#list_append(i + 1, rng)
		#
	#var tile5_rng = children - ctr
	#list_append(5, tile5_rng)
	#
	#distributed_tile_list.shuffle()
#
#func list_append(tile_type, rng):
	#for i in range(rng):
		#distributed_tile_list.append(str(tile_type))
		
func _physics_process(delta):
	get_collisions()
	
func get_collisions():
	for tiles in get_children():
		for layers in tiles.get_children():
			if layers.get_name() == "Raycast":
				for raycast in layers.get_children():
					if raycast.is_colliding():
						print(tiles)
		

	
