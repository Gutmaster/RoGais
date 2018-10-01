extends "res://Passive/Passive.gd"


func _ready():
	stats.Endurance = 1
	stats.Vitality = 1
	descript[0] = "1. Each hit Billy takes moves him up in the Queue"


func _process(delta):
	pass


func Init():
	pass


func _on_Item_mouse_entered():
	HoverInfo()


func _on_Item_mouse_exited():
	NoHover()