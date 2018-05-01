extends Node2D



func _ready():
	pass


func Dump():
	while(get_child_count() != 0):
		get_node("/root/Globals").party.get_node("PanelContainer/VBoxContainer/HBoxContainer/Unit Cards").remove_child(get_child(0).quickStats)
		get_child(0).free()
