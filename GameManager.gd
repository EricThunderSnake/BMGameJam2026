extends Node2D

@onready var main_menu = $"Main Menu"
@onready var play_button = $"Main Menu/PlayButton"
var running = false

var levelList: Array[Level]

func _ready():
	play_button.connect("pressed", play_game)

	
	
func play_game():
	# Use load() instead of preload() if the path isn't known at compile-time.
	var scene = preload("res://Level 1.tscn").instantiate()
# Add the node as a child of the node the script is attached to.
	add_child(scene)
	main_menu.visible = false
