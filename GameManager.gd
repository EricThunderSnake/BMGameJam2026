extends Node2D

@onready var main_menu = $"Main Menu"
@onready var play_button = $"Main Menu/PlayButton"
const Level1Scene = "uid://bv06kv8xwrxd6"
var running = false

var levelList: Array[Level]

func _ready():
	play_button.connect("pressed", play_game)
	Audio.setup_button_audio(self)
	
func play_game():
	# Use load() instead of preload() if the path isn't known at compile-time.
	var scene = preload(Level1Scene).instantiate()
	print(scene)
# Add the node as a child of the node the script is attached to.
	get_tree().change_scene_to_node(scene)
	main_menu.visible = false
