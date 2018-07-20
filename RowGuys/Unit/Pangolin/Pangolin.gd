extends "res://Unit/Unit.gd"

func _ready():
	pass


func Init():
	idName = "Pangolin"
	
	bStats.Strength = 2
	bStats.Speed = 3
	bStats.Vitality = 5
	bStats.Stamina = 4
	
	SharedInit()
	defaultRow = ROW.front
	
	SFX.hit = load("res://SFX/Wood.wav")