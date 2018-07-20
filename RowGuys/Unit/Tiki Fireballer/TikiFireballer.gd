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
	
	SFX.hit = load("res://SFX/OopsHorseNoise.wav")
	var SFXPatch = {"fbtravel": load("res://SFX/FireballTravel.wav"), "fbhit": load("res://SFX/FireballHit.wav")}
	merge_dir(SFX, SFXPatch)


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