extends "res://Unit/Unit.gd"


func _ready():
	idName = "Dank Druid"
	Init()
	
	stats.Strength = 1
	stats.Wisdom = 3
	stats.Vitality = 4
	stats.Stamina = 7
	stats.Speed = 5
	stats.hp = stats.Vitality
	stats.ap = stats.Stamina
	
	defaultRow = ROW.back
	
	actionList.push_back(get_node("ActionCatalogue/Ensnaring Vines"))
	actionList.push_back(get_node("ActionCatalogue/Minor Beast"))