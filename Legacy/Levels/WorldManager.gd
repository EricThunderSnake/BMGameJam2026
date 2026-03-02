extends Node3D

signal s_turn_started(unit: Unit)
@onready var TurnManager = $"../TurnManager"
@onready var units = $Units
var unitArray: Array[Unit] = []
var new_unit_index : int = 0
var camera : Camera2D
@onready var gridmap : GridMap = $Map/GridMap

func _ready():
	print(get_child_count())
	initialise_units()
	process_mode =Node.PROCESS_MODE_PAUSABLE


func _process(delta: float) -> void:
	for unit in unitArray:
		print(unit.name)
		s_turn_started.emit(unit)
		await TurnManager.s_turn_ended

		
		

func initialise_units():
	units.process_mode = Node.PROCESS_MODE_ALWAYS

	var unitObjects = units.get_children()
	var camera_attached = false
	for unit in unitObjects:
		if unit is not Unit:
			continue
		#if !camera_attached:
			#camera = 
			#camera.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS
			#unit.add_child(camera)
			#camera.make_current()
			#camera_attached = true
		unitArray.append(unit)
	assert(!unitArray.is_empty(), "Error: The Unit Manager must have at least one unit!")
