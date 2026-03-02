class_name Unit
extends CharacterBody3D

@export var _name: String = "NoName"
@export var _position: Vector2i =  Vector2i(0,0)
enum Class {UNIT, BARBARIAN, FIGHTER}
var _class: Class = Class.UNIT
@export var _max_health: int = 10
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
	process_mode = Node.PROCESS_MODE_ALWAYS

func GetName() -> String:
	return _name
