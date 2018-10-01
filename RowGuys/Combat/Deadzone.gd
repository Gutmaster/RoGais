extends Node2D



func _ready():
	pass


func Dump():
	while(get_child_count() != 0):
		if(get_child(0).quickStats != null):
			get_child(0).quickStats.free()
		get_child(0).free()
