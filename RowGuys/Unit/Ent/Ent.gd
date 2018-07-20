extends "res://Unit/Unit.gd"


func _ready():
	pass


func Init():
	idName = "Ent"
	
	bStats.Stamina = 7
	bStats.Speed = 3
	bStats.Strength = 6
	bStats.Vitality = 8
	
	xpReward = 7
	goldReward = 5
	itemVal = 10
	
	SharedInit()
	defaultRow = ROW.middle
	
	actionList.push_back(get_node("ActionCatalogue/Blockade"))
	actionList.push_back(get_node("ActionCatalogue/Sweeping Strike"))
	
	SFX.hit = load("res://SFX/Wood.wav")

func AICmd():
	if(PassCheck()):
		return
		
	if(AIAdvance()):
		return
	
	if(!AIShift):
		AIApproach()
		AIShift = true
	elif(!AIAction):
		if(ap >= FindAction("Blockade").apCost
		and !team.enemy.rpos.back.terrain.tags.exists):
			AIBlockade()
		elif(ap >= FindAction("Sweeping Strike").apCost):
			AISweepingStrike()
		else:
			AIRandomMelee()
		AIAction = true


func AISweepingStrike():
	var action = FindAction("Sweeping Strike")
	action.FindTargetOptions(team)
	
	var target = action.targetOptions[0]
	
	action.Init(self, target)


func AIBlockade():
	var action = FindAction("Blockade")
	action.FindTargetOptions(team)
	
	var target = action.targetOptions[0]
	
	action.Init(self, target)