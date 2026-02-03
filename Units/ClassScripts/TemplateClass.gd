class_name TemplateClass
extends Unit

func _init():
	super()
	_position =  Vector2i(0,0) # Vector2i
	_class = "TemplateClass" # String
	_health = 10 # int
	_attack = 5 # int
	_armor_class = 3 # int

func TakeTurn():
	super()
	print("I am a basic bitch")
