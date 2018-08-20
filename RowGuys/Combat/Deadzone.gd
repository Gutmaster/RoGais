extends Node2D



func _ready():
	pass


func Dump():
	while(get_child_count() != 0):
		get_child(0).free()
