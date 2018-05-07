extends "res://Unit/Unit.gd"


func _ready():
	pass


func Init():
	idName = "Dank Druid"
	
	bStats.Strength = 1
	bStats.Wisdom = 3
	bStats.Vitality = 4
	bStats.Stamina = 7
	bStats.Speed = 5
	
	SharedInit()
	defaultRow = ROW.back
	
	actionList.push_back(get_node("ActionCatalogue/Ensnaring Vines"))
	actionList.push_back(get_node("ActionCatalogue/Minor Beast"))