extends "res://Unit/Unit.gd"


func _ready():
	pass


func Init():
	idName = "Senor Salvadia"
	SharedInit()
	
	stats.Stamina = 5
	stats.Speed = 6
	stats.Strength = 3
	stats.Vitality = 4
	stats.Endurance = 3
	stats.hp = stats.Vitality
	stats.ap = stats.Stamina
	
	defaultRow = ROW.middle
	
	#actionList.push_back(get_node("ActionCatalogue/Tongue Snatch"))
	actionList.push_back(get_node("ActionCatalogue/Leaping Strike"))
	actionList.push_back(get_node("ActionCatalogue/Firecracker Flip"))
	actionList.push_back(get_node("ActionCatalogue/Stunning Smash"))