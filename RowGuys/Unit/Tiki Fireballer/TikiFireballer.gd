extends "res://Unit/Unit.gd"


func _ready():
	pass


func Init():
	idName = "Tiki Fireballer"
	SharedInit()
	
	stats.Strength = 1
	stats.Wisdom = 3
	stats.Vitality = 4
	stats.Stamina = 7
	stats.Speed = 4
	stats.hp = stats.Vitality
	stats.ap = stats.Stamina
	
	defaultRow = ROW.back
	
	actionList.push_back(get_node("ActionCatalogue/Fireball"))
	stanceList.push_back(get_node("StanceCatalogue/Fire Dance"))