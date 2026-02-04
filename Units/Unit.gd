class_name Unit
extends Node2D

signal player_ready

var player_turn = true

@export var _name: String = "NoName"
@export var _position: Vector2i =  Vector2i(0,0)
static var _class: String = "Unit"
@export var _health: int = 10
@export var _attack: int = 5
@export var _armor_class: int = 3

enum Controller {COMPUTER = 0, PLAYER = 1}
@export var controller: Controller

@onready var sprite: Sprite2D = $Sprite2D


func _init():
	pass	
	_health = 5 #experiment

func TakeTurn():
	if controller == Controller.PLAYER:
		print(controller) # currently, the game is printing 1, so
		# we are entering this branch, but the game does not wait
		# for a player_ready signal to be emitted
		# As of yet, there is nowhere in the code where player_ready
		# is called. This means I misunderstand signals
		await player_ready
	else:
		pass

func _input(event):
	pass
