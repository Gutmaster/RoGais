extends "res://Unit/Unit.gd"

func _ready():
	idName = "Pangolin"
	Init()
	
	stats.Strength = 2
	stats.Speed = 10
	stats.Vitality = 5
	stats.hp = stats.Vitality
	
	defaultRow = ROW.front