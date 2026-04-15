extends Node3D

signal s_turn_ended
signal unit_moved
@onready var pointer: Pointer = $Pointer
@onready var mesh: MeshInstance3D = $Pointer/Mesh
@onready var action_menu = $ActionMenu
var width : int
var height : int
var recently_moved = false

const Left = "Left"
const Right = "Right"
const Up = "Up"
const Down = "Down"

var active_unit: Unit
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
@onready var worldManager : WorldManager = $"../WorldManager"

var unit_moving = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	pointer.visible = true
	worldManager.s_turn_started.connect(TakeTurn)
	action_menu.move.pressed.connect(on_move)
	action_menu.skip.pressed.connect(on_skip)
	width = mesh.mesh.get_aabb().size.x
	height = mesh.mesh.get_aabb().size.y 
	timer = Timer.new()
	timer.process_mode = Node.PROCESS_MODE_INHERIT
	timer.one_shot = true
	timer.wait_time = move_delay
	add_child(timer)


func _process(delta):
	
	if !unit_moving:
		return
	

	var movement = width * Input.get_vector(Left, Right, Up, Down).sign()
	if !timer.is_stopped() && movement == Vector2.ZERO:
		timer.stop()
		
	
	if timer.is_stopped() && movement != Vector2.ZERO:
		pointer.position += Vector3(movement.x, 0, movement.y)
		
		last_pressed[Left] = true if movement.x < 0 else false
		last_pressed[Right] = true if movement.x > 0 else false
		last_pressed[Up] = true if movement.y < 0 else false
		last_pressed[Down] = true if movement.y > 0 else false
		
		timer.start()

func TakeTurn(unit:Unit):
	assert(unit != null, "unit is Null")
	active_unit = unit
	action_menu.unit_name.text = active_unit.GetName() + "'s Turn"
	action_menu.visible = true
	pointer.position = active_unit.position - Vector3(0, 2.2, 0)
	get_tree().paused = true
	PhysicsServer3D.set_active(true)

func _input(event):
	if !unit_moving:
		return
	if event.is_action_pressed("ui_accept"):
		finalise_movement(active_unit)
	if event.is_action_pressed("ui_cancel"):
		pointer.visible = false
		#pointer.position = active_unit.position
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
	
func is_valid_target_position(unit: Unit) -> bool:

	var tile_position = pointer.raycast.get_collision_point() - Vector3(0,1,0)
	print(tile_position)
	var tile_id : int = worldManager.gridmap.get_cell_item(tile_position / 2 )
	print(tile_id)
	var present_units := pointer.get_overlapping_bodies()
	print(present_units)
	if present_units.size() <= 1: # present_units will always contain the gridmap
		pass                     # need to adjust physics layers so this doesn't happeb
	elif present_units.has(active_unit):
		print("You are already here.")
	else:
		return false
		
	if tile_id == 1: # water
		return false
	return true

func finalise_movement(unit: Unit):
	if !unit_moving:
		return
	if !is_valid_target_position(unit):
		print("the unit cannot get here")
		return
	pointer.visible = false
	unit.position = pointer.position + Vector3(0, 2.2, 0)
	action_menu.move.visible = false
	unit_moving = false
	action_menu.visible = true
	unit_moved.emit()
	
