extends "res://Unit/Unit.gd"


var frenzy = false
var mark = null
var bloodsong = false


func _ready():
	pass


func Init():
	idName = "Billy Beastman"
	
	bStats.Vitality = 20
	bStats.Stamina = 5
	bStats.Endurance = 1
	bStats.Strength = 4
	bStats.Speed = 5
	bStats.Willpower = 3
	
	SharedInit()
	defaultRow = ROW.front
	
	skillTree = load("res://Unit/Billy Beastman/SkillTree/BeastmanTree.tscn").instance()
	skillTree.unit = self
	
	SFX.hit = load("res://SFX/Oof.wav")


func SpecialCheck(source):
	if(frenzy):
		source.Mark(self)
	if(bloodsong):
		initiative += aStats.Willpower*3