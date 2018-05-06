extends "res://Unit/Unit.gd"


func _ready():
	pass


func Init():
	idName = "Ent"
	SharedInit()
	
	stats.Stamina = 7
	stats.Speed = 2
	stats.Strength = 6
	stats.Vitality = 8
	stats.hp = stats.Vitality
	stats.ap = stats.Stamina
	
	defaultRow = ROW.middle
	
	actionList.push_back(get_node("ActionCatalogue/Blockade"))
	actionList.push_back(get_node("ActionCatalogue/Sweeping Strike"))


func AICmd():
	if(PassCheck()):
		return
		
	if(!AIShift):
		AIAdvance()
		AIShift = true
	elif(!AIAction):
		if(stats.ap >= FindAction("Blockade").apCost
		and !team.enemy.rpos.back.terrain.tags.exists):
			AIBlockade()
		elif(stats.ap >= FindAction("Sweeping Strike").apCost):
			AISweepingStrike()
		else:
			AIRandomMelee()
		AIAction = true


func AISweepingStrike():
	var action = FindAction("Sweeping Strike")
	action.set_process(true)
	action.FindTargetOptions(team)
	
	var target = action.targetOptions[0]
	
	action.Animate(self, target)
	action.phase = 1
	cAction = action


func AIBlockade():
	var action = FindAction("Blockade")
	action.set_process(true)
	action.FindTargetOptions(team)
	
	var target = action.targetOptions[0]
	
	action.Animate(self, target)
	action.phase = 1
	cAction = action