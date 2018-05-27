extends "res://Unit/Unit.gd"


func _ready():
	pass


func Init():
	idName = "Senor Salvadia"
	
	bStats.Stamina = 5
	bStats.Speed = 8
	bStats.Strength = 10
	bStats.Vitality = 4
	bStats.Endurance = 3
	
	SharedInit()
	defaultRow = ROW.middle
	
	actionList.push_back(get_node("ActionCatalogue/Tongue Snatch"))
	actionList.push_back(get_node("ActionCatalogue/Leaping Strike"))
	actionList.push_back(get_node("ActionCatalogue/Firecracker Flip"))