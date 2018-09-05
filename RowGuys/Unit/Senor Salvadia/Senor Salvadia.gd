extends "res://Unit/Unit.gd"


func _ready():
	pass


func Init():
	idName = "Senor Salvadia"
	
	bStats.Stamina = 5
	bStats.Speed = 6
	bStats.Strength = 3
	bStats.Vitality = 4
	bStats.Endurance = 3
	
	SharedInit()
	defaultRow = ROW.middle
	
	skillTree = load("res://Unit/Senor Salvadia/SkillTree/SenorTree.tscn").instance()
	skillTree.unit = self
	
	actionList.push_back(get_node("ActionCatalogue/Tongue Snatch"))
	actionList.push_back(get_node("ActionCatalogue/Leaping Strike"))
	#actionList.push_back(get_node("ActionCatalogue/Firecracker Flip"))
	
	SFX.hit = load("res://SFX/Oof.wav")
	var SFXPatch = {"tongue": load("res://SFX/Tongue.wav"), "fbhit": load("res://SFX/FireballHit.wav")}
	merge_dir(SFX, SFXPatch)