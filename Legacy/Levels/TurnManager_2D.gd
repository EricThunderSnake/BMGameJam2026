extends Node3D

signal s_turn_ended
signal unit_moved
@onready var pointer: Pointer2D = $Pointer
@onready var sprite: Sprite2D = $Pointer/Sprite2D
@onready var action_menu = $ActionMenu
var width : int
var height : int
var recently_moved = false

const Left = "Left"
const Right = "Right"
const Up = "Up"
const Down = "Down"

var active_unit: Unit2D
var last_pressed := {
	Left: false,
	Right: false,
	Up: false,
	Down: false
}
var ex_last_pressed = Vector2(0,0)

var move_delay = 0.35
var timer: Timer

var processing_turn = false
@onready var WorldManager = $"../WorldManager"

var unit_moving = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	pointer.visible = true
#	WorldManager.s_turn_started.connect(TakeTurn)
	action_menu.move.pressed.connect(on_move)
	action_menu.skip.pressed.connect(on_skip)
	width = sprite.texture.get_width()
	height = sprite.texture.get_height()
	timer = Timer.new()
	timer.process_mode = Node.PROCESS_MODE_INHERIT
	timer.one_shot = true
	timer.wait_time = move_delay
	add_child(timer)


func _process(delta):
	
	if !unit_moving:
		return
	
	print(pointer.get_overlapping_bodies())
	var movement = width * Input.get_vector(Left, Right, Up, Down).sign()
	#print(timer.time_left)
	if !timer.is_stopped() && movement == Vector2.ZERO:
		timer.stop()
	
	if timer.is_stopped() && movement != Vector2.ZERO:
		pointer.position += movement
		
		last_pressed[Left] = true if movement.x < 0 else false
		last_pressed[Right] = true if movement.x > 0 else false
		last_pressed[Up] = true if movement.y < 0 else false
		last_pressed[Down] = true if movement.y > 0 else false
		
		timer.start()

func TakeTurn(unit:Unit2D):
	
	active_unit = unit
	print(active_unit.GetName())
	action_menu.unit_name.text = active_unit.GetName() + "'s Turn"
	action_menu.visible = true
	pointer.position = active_unit.position
	get_tree().paused = true
	PhysicsServer2D.set_active(true)

func _input(event):
	if !unit_moving:
		return
	if event.is_action_pressed("ui_accept"):
		finalise_movement(active_unit)
	if event.is_action_pressed("ui_cancel"):
		pointer.visible = false
		pointer.position = active_unit.position
		unit_moving = false
		action_menu.visible = true
		

func on_move():
	unit_moving = true
	pointer.visible = true
	action_menu.visible = false
	
	
	

func on_skip():
	action_menu.visible = false
	if !action_menu.move.visible:
		action_menu.move.visible = true
	get_tree().paused = false
	s_turn_ended.emit()
	
func is_valid_target_position(unit: Unit2D) -> bool:
	var cell = WorldManager.tilemap.local_to_map(pointer.position)
	var data = WorldManager.tilemap.get_cell_tile_data(cell)
	
	print(pointer.get_overlapping_areas())
	
	var present_units := pointer.get_overlapping_bodies()
	if present_units.is_empty():
		pass
	elif present_units.has(active_unit):
		print("You are already here.")
	else:
		return false

	if data.get_custom_data("is_water"):
		return false
	return true

func finalise_movement(unit: Unit2D):
	if !unit_moving:
		return
	if !is_valid_target_position(unit):
		print("the unit cannot get here")
		return
	pointer.visible = false
	unit.position = pointer.position
	action_menu.move.visible = false
	unit_moving = false
	action_menu.visible = true
	unit_moved.emit()
	
