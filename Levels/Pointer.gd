class_name Pointer
extends Area3D

@onready var raycast : RayCast3D = $Collider/RayCast3D


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
