extends "res://Unit/Unit.gd"


var growthList = []


func _ready():
	pass


func Init():
	idName = "Dank Druid"
	
	bStats.Strength = 5
	bStats.Wisdom = 3
	bStats.Vitality = 4
	bStats.Stamina = 6
	bStats.Speed = 5
	
	SharedInit()
	defaultRow = ROW.back
	
	skillTree = load("res://Unit/Dank Druid/SkillTree/DruidTree.tscn").instance()
	skillTree.unit = self
	
	SFX.hit = load("res://SFX/Oof.wav")
	var SFXPatch = {"vines": load("res://SFX/Vines.wav")}
	merge_dir(SFX, SFXPatch)


func Growth():
	var dump = []
	
	for i in range(growthList.size()):
		growthList[i].gClock -= 1