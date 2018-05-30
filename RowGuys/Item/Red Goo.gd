extends "res://Item/Item.gd"


func _ready():
	power = 5
	buyPrice = 5
	sellPrice = 2


func Use(unit):
	unit.UpdateHP(5)#power