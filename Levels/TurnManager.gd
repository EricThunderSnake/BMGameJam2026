extends Node2D

signal turn_ended
@onready var pointer: Node2D = $Pointer
@onready var sprite: Sprite2D = $Pointer/Sprite2D
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
@onready var UnitManager = $"../UnitManager"

var unit_moving = false

func _ready():
	pointer.visible = false
	UnitManager.turn_started.connect(TakeTurn)
	action_menu.move.pressed.connect(on_move)
	action_menu.skip.pressed.connect(on_skip)
	width = sprite.texture.get_width()
	height = sprite.texture.get_height()
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	timer = Timer.new()
	timer.process_mode = Node.PROCESS_MODE_INHERIT
	timer.one_shot = true
	timer.wait_time = move_delay
	add_child(timer)
	


func _process(delta):
	if !unit_moving:
		return
	var movement = width * Input.get_vector(Left, Right, Up, Down).sign()
	print(timer.time_left)
	if !timer.is_stopped() && movement == Vector2.ZERO:
		timer.stop()
	
	if timer.is_stopped() && movement != Vector2.ZERO:
		pointer.position += movement
		
		last_pressed[Left] = true if movement.x < 0 else false
		last_pressed[Right] = true if movement.x > 0 else false
		last_pressed[Up] = true if movement.y < 0 else false
		last_pressed[Down] = true if movement.y > 0 else false
		
		timer.start()
	print(pointer.position)

func TakeTurn(unit: Unit):
	active_unit = unit
	action_menu.unit_name.text = active_unit.GetName() + "'s Turn"
	action_menu.visible = true	
	pointer.position = unit.position
	get_tree().paused = true
	

func _input(event):
	if unit_moving:
		if event.is_action_pressed("ui_accept"):
			pointer.visible = false
			active_unit.position = pointer.position
			action_menu.move.visible = false
			unit_moving = false
			action_menu.visible = true
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
	turn_ended.emit()
