extends "res://Unit/Unit.gd"


var growthList = []


func _ready():
	pass


func Init():
	idName = "Dank Druid"
	
	bStats.Strength = 5
	bStats.Wisdom = 3
	bStats.Vitality = 4
	bStats.Stamina = 7
	bStats.Speed = 30
	
	SharedInit()
	defaultRow = ROW.back
	
	skillTree = load("res://Unit/Dank Druid/SkillTree/DruidTree.tscn").instance()
	skillTree.unit = self


func Growth():
	var dump = []
	
	for i in range(growthList.size()):
		growthList[i].gClock -= 1