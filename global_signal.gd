extends Node

signal changed_resource
signal roll

func resources():
	changed_resource.emit()

func roll_sum():
	roll.emit()

