extends Node3D

@onready var raycasts = $Raycasts.get_children()
#colliding_with 1 = house
#colliding_with 2 = road

signal placed(value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for raycast in raycasts:
		if raycast.is_colliding():
			placed.emit(raycast.colliding_with)
			print("imdiwmdiwmdiwmidmwid")

func _on_placed(value):
	print(value)
