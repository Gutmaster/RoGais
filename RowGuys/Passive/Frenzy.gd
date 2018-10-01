extends "res://Passive/Passive.gd"


func _ready():
	stats.Stamina = 1
	descript[0] = "1. Whenever Billy receives combat damage he marks the source. Marked targets take an additional 50% damage."


func _process(delta):
	pass


func Init():
	pass


func _on_Item_mouse_entered():
	HoverInfo()


func _on_Item_mouse_exited():
	NoHover()