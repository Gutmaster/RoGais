extends "res://Unit/Unit.gd"


func _ready():
	pass


func Init():
	idName = "Dank Druid"
	
	bStats.Strength = 1
	bStats.Wisdom = 3
	bStats.Vitality = 4
	bStats.Stamina = 7
	bStats.Speed = 4
	
	SharedInit()
	defaultRow = ROW.back
	
	skillTree = load("res://Unit/Dank Druid/SkillTree/DruidTree.tscn").instance()
	skillTree.unit = self