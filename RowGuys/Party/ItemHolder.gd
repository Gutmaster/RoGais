extends Node2D


onready var item = null
onready var itemLastFrame = item

func _ready():
	pass


func _process(delta):
	if(item != itemLastFrame):
		if(item != null):
			add_child(item)
	
	itemLastFrame = item
	global_position = get_global_mouse_position()