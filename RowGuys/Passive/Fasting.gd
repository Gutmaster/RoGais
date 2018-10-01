extends "res://Passive/Passive.gd"


func _ready():
	descript[0] = "1. This unit's Wisdom and Willpower will increase rather than decrease while starving."


func _process(delta):
	pass


func Init():
	pass


func _on_Item_mouse_entered():
	HoverInfo()


func _on_Item_mouse_exited():
	NoHover()