extends "res://Unit/Unit.gd"


var frenzy = false
var mark = null
var bloodsong = false


func _ready():
	pass


func Init():
	idName = "Billy Beastman"
	
	bStats.Vitality = 80
	bStats.Stamina = 5
	bStats.Endurance = 3
	bStats.Strength = 3
	bStats.Speed = 5
	bStats.Willpower = 3
	
	SharedInit()
	defaultRow = ROW.front
	
	actionList.push_back(get_node("ActionCatalogue/Stunning Smash"))
	stanceList.push_back(get_node("StanceCatalogue/Protect"))

	skillTree = load("res://Unit/Billy Beastman/SkillTree/BeastmanTree.tscn").instance()
	skillTree.unit = self


func CombatDamage(source, dmg):
	.CombatDamage(source, dmg)
	if(frenzy):
		source.Mark(self)
	if(bloodsong && dmg > 0):
		initiative += aStats.Willpower*3