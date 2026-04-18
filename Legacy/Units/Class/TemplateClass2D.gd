class_name TemplateClass
extends Unit2D

func _init():
	super()
	_position =  Vector2i(0,0) # Vector2i
	_class = Class.UNIT # String
	_max_health = 10 # int
	_health = _max_health
	_attack = 5 # int
	_armor_class = 3 # int
