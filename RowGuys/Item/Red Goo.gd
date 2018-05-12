extends "res://Item/Item.gd"


func _ready():
	power = 5


func Use(unit):
	unit.UpdateHP(5)#power