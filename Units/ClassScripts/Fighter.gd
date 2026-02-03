class_name Fighter
extends Unit

func _init():
	super()
	_name = "Fighter"
	_position =  Vector2i(0,0) # Vector2i
	_class = "BaseClass" # String
	_health = 10 # int
	_attack = 5 # int
	_armor_class = 3 # int

func TakeTurn():
	super()
	#print("Taking backshots for the team")
