extends Node2D

var units: Array[Unit] = []

func _ready():
	assert(!get_children().is_empty(), "Error: The Unit Manager must have at least one unit!")
	for unit in get_children():
		if unit is Unit:
			units.append(unit)
			
func _process(delta: float) -> void:
	for unit in units:
		if unit is Unit:
			unit.TakeTurn()
