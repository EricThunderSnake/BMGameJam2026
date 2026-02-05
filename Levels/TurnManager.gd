extends Node2D

@onready var pointer: Node2D = $Pointer
@onready var sprite: Sprite2D = $Pointer/Sprite2D
var width : int
var height : int
enum LastPressed {NULL, RIGHT, LEFT, UP, DOWN}
var last_pressed = LastPressed.NULL
var move_delay = 2
var timer: Timer


func _ready():
	width = sprite.texture.get_width()
	height = sprite.texture.get_height()
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	timer = Timer.new()
	timer.process_mode = Node.PROCESS_MODE_INHERIT
	timer.one_shot = true
	timer.wait_time = move_delay
	add_child(timer)

func _process(delta):
	pass

func _input(event):
	if event.is_action("Right"):
		
		if last_pressed == LastPressed.RIGHT:
			if timer.time_left == 0:
				print("HEllo")
				timer.start()
				await timer.timeout
				pointer.position.x += width
		else:
			print("secant")
			pointer.position.x += width
			last_pressed = LastPressed.RIGHT
	if event.is_action_pressed("Left"):
		pointer.position.x -= width
		last_pressed = LastPressed.LEFT
	if event.is_action_pressed("Up"):
		pointer.position.y -= height
		last_pressed = LastPressed.UP
	if event.is_action_pressed("Down"):
		pointer.position.y += height
		last_pressed = LastPressed.DOWN

		
