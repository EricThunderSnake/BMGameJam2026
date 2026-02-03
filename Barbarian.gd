class_name Barbarian
extends Unit

func _init():
	super()
	_name = "Barbarian"
	_position =  Vector2i(0,0) # Vector2i
	_class = "Barbarian" # String
	_health = 10 # int
	_attack = 5 # int
	_armor_class = 3 # int

func TakeTurn():
	#print("Ready to bust")
	super()
	#print("Backshot in the head")
