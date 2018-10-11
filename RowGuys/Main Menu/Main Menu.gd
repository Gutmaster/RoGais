extends Node2D


func _ready():
	add_child(get_node("/root/Globals").party)