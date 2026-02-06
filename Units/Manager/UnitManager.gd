extends Node2D

signal turn_started(unit: Unit)
@onready var TurnManager = $"../TurnManager"
var units: Array[Unit] = []

func _ready():
	assert(!get_children().is_empty(), "Error: The Unit Manager must have at least one unit!")
	for unit in get_children():
		if unit is not Unit:
			continue
		units.append(unit)
func _process(delta: float) -> void:
	for unit in units:
		print(unit.name)
		turn_started.emit(unit)
		await TurnManager.turn_ended
		print("hhmmmmmm")
