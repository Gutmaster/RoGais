extends "res://Unit/Unit.gd"

func _ready():
	pass


func Init():
	idName = "Pangolin"
	
	bStats.Strength = 2
	bStats.Speed = 10
	bStats.Vitality = 5
	
	SharedInit()
	defaultRow = ROW.front