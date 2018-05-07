extends "res://Unit/Unit.gd"


func _ready():
	pass


func Init():
	idName = "Billy Beastman"
	
	bStats.Vitality = 8
	bStats.Stamina = 5
	bStats.Endurance = 3
	bStats.Strength = 3
	bStats.Speed = 7
	
	SharedInit()
	defaultRow = ROW.front
	
	actionList.push_back(get_node("ActionCatalogue/Stunning Smash"))