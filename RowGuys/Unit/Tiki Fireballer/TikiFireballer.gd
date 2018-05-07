extends "res://Unit/Unit.gd"


func _ready():
	pass


func Init():
	idName = "Tiki Fireballer"
	
	bStats.Strength = 1
	bStats.Wisdom = 3
	bStats.Vitality = 4
	bStats.Stamina = 7
	bStats.Speed = 4
	
	
	SharedInit()
	defaultRow = ROW.back
	
	actionList.push_back(get_node("ActionCatalogue/Fireball"))
	stanceList.push_back(get_node("StanceCatalogue/Fire Dance"))


func Starve():
	Subtributes(starveNerf)
	starveLvl += 1
	starveNerf.Vitality = -starveLvl
	starveNerf.Stamina = -starveLvl
	starveNerf.Strength = -starveLvl
	starveNerf.Wisdom = starveLvl
	starveNerf.Endurance = -starveLvl
	starveNerf.Willpower = starveLvl
	starveNerf.Speed = -starveLvl
	Addributes(starveNerf)