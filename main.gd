extends Node

@onready var label = $CanvasLayer/Label

func _on_die_roll_finished(value):
	label.text = str(value)
