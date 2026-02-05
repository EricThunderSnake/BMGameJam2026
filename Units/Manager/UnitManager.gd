extends Node2D

var units: Array[Unit] = []

func _ready():
	assert(!get_children().is_empty(), "Error: The Unit Manager must have at least one unit!")
	for unit in get_children():
		if unit is not Unit:
			continue
		units.append(unit)
			
func _process(delta: float) -> void:
	for unit in units:
		unit.turn_started.emit()
		await unit.turn_finished
		print("hhmmmmmm")
