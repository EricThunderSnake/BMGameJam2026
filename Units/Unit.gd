class_name Unit
extends Node2D

signal turn_started
signal turn_finished

@export var _name: String = "NoName"
@export var _position: Vector2i =  Vector2i(0,0)
enum Class {UNIT, BARBARIAN, FIGHTER}
var _class: Class = Class.UNIT
@export var _health: int = 10
@export var _attack: int = 5
@export var _armor_class: int = 3

enum Controller {COMPUTER = 0, PLAYER = 1}
@export var controller: Controller

@onready var sprite: Sprite2D = $Sprite2D


func _init():
	pass	
	_health = 5 #experiment

func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	turn_started.connect(TakeTurn)

func TakeTurn():
	if controller == Controller.PLAYER:
		print(_name)
		get_tree().paused = true
		#get_tree().paused = false # currently, the game is printing 1, so
		# we are entering this branch, but the game does not wait
		# for a player_ready signal to be emitted
		# As of yet, there is nowhere in the code where player_ready
		# is called. This means I misunderstand signals
	else:
		pass

func _input(event):
	if event.is_action_released("ui_accept"):
		print("hello")
		position.x += sprite.texture.get_width()
