extends Node2D

signal turn_ended
@onready var pointer: Node2D = $Pointer
@onready var sprite: Sprite2D = $Pointer/Sprite2D
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
func _ready():
	
	UnitManager.turn_started.connect(TakeTurn)
	
	width = sprite.texture.get_width()
	height = sprite.texture.get_height()
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	timer = Timer.new()
	timer.process_mode = Node.PROCESS_MODE_INHERIT
	timer.one_shot = true
	timer.wait_time = move_delay
	add_child(timer)


func _process(delta):
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
	get_tree().paused = true
	active_unit = unit
	pointer.position = unit.position

func _input(event):
	if event.is_action_pressed("ui_accept"):
		active_unit.position = pointer.position
		get_tree().paused = false
		turn_ended.emit()
			
	
