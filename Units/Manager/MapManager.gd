extends Node2D

signal turn_started(unit: Unit)
@onready var TurnManager = $"../TurnManager"
@onready var units = $Units
var unitArray: Array[Unit] = []
var test3dArray : Array[Array] = [[{}]]


func _ready():
	initialise_map()
	initialise_units()
	


func _process(delta: float) -> void:
	for unit in unitArray:
		print(unit.name)
		turn_started.emit(unit)
		await TurnManager.turn_ended
		print("hhmmmmmm")

func initialise_map():
	for row in test3dArray:
		for cell in row:
			assert(cell is Dictionary, "fuci")
	pass

func initialise_units():
	var unitObjects = units.get_children()
	for unit in unitObjects:
		if unit is not Unit:
			continue
		unitArray.append(unit)
	assert(!unitArray.is_empty(), "Error: The Unit Manager must have at least one unit!")
