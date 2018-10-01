extends "res://Unit/Unit.gd"


var fasting = false


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
	
	skillTree = load("res://Unit/Tiki Fireballer/SkillTree/TikiTree.tscn").instance()
	skillTree.unit = self
	
	SFX.hit = load("res://SFX/OopsHorseNoise.wav")
	var SFXPatch = {"fbtravel": load("res://SFX/FireballTravel.wav"), "fbhit": load("res://SFX/FireballHit.wav")}
	merge_dir(SFX, SFXPatch)


func Starve():
	if(!fasting):
		.Starve()
		return
	
	starveLvl += 1
	starveNerf.Vitality = -starveLvl
	starveNerf.Stamina = -starveLvl
	starveNerf.Strength = -starveLvl
	starveNerf.Wisdom = starveLvl
	starveNerf.Endurance = -starveLvl
	starveNerf.Willpower = starveLvl
	starveNerf.Speed = -starveLvl
	Addributes(starveNerf)