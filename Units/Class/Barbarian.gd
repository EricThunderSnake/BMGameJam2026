class_name Barbarian
extends Unit

func _init():
	super()
	_name = "Barbarian"
	_position =  Vector2i(0,0) # Vector2i
	_max_health = 10 # int
	_health = _max_health
	_attack = 5 # int
	_armor_class = 3 # int
	
func _ready():
	super()
	_class = Class.BARBARIAN
