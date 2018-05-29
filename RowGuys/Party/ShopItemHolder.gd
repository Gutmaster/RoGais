extends Node2D


onready var itemCatcher = null
onready var item = null
onready var itemLastFrame = item

func _ready():
	pass


func _process(delta):
	if(item != itemLastFrame):
		if(item != null):
			item.get_parent().remove_child(item)
			add_child(item)
	
	itemLastFrame = item
	global_position = get_global_mouse_position() - Vector2(25,25)