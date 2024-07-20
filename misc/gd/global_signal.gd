extends Node

signal changed_resource
signal roll
signal time

func resources():
	changed_resource.emit()

func roll_sum():
	roll.emit()

func time_out():
	time.emit()
