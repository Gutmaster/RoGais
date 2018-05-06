extends "res://Unit/Unit.gd"


func _ready():
	pass


func Init():
	idName = "Billy Beastman"
	SharedInit()
	
	
	stats.Vitality = 8
	stats.Stamina = 5
	stats.Endurance = 3
	stats.Strength = 3
	stats.Speed = 7
	stats.hp = stats.Vitality
	stats.ap = stats.Stamina
	
	defaultRow = ROW.front
	
	actionList.push_back(get_node("ActionCatalogue/Stunning Smash"))