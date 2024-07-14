extends Node

@onready var label = $CanvasLayer/Label

var die1 = 0
var die2 = 0

func _on_die_roll_finished(value):
	die1 = value
	is_diefinished()

func _on_die_2_roll_finished(value):
	die2 = value
	is_diefinished()

func is_diefinished():
	if die1 && die2:
		var die_value = die1 + die2
		print("die output: ", die_value)
		
		die1 = 0
		die2 = 0
