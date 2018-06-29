extends "res://Unit/Unit.gd"


func _ready():
	pass


func Init():
	idName = "Froggodile"
	
	bStats.Stamina = 5
	bStats.Speed = 4
	bStats.Strength = 3
	bStats.Vitality = 4
	
	xpReward = 3
	goldReward = 1
	itemVal = 3
	
	SharedInit()
	defaultRow = ROW.back
	
	actionList.push_back(get_node("ActionCatalogue/Tongue Snatch"))
	actionList.push_back(get_node("ActionCatalogue/Poison Jaws"))


func AICmd():
	if(PassCheck()):
		return
		
	if(!AIShift):
		if(team.enemy.rpos.front.FindOccupants().size()):
			AIApproach()
		AIShift = true
	elif(!AIAction):
		if(rowRef == team.rpos.front and \
		   team.enemy.rpos.front.FindOccupants().size() and \
		   ap >= FindAction("Poison Jaws").apCost):
			AIPoisonJaws()
		elif(ap >= FindAction("Tongue Snatch").apCost):
			AITongueSnatch()
		AIAction = true


func AITongueSnatch():
	var action = FindAction("Tongue Snatch")
	action.FindTargetOptions(team.enemy)
	
	randomize()
	if(action.targetOptions.size()):
		var target = action.targetOptions[randi()%action.targetOptions.size()]
	
		action.Init(self, target)


func AIPoisonJaws():
	var action = FindAction("Poison Jaws")
	action.FindTargetOptions(team.enemy)
	randomize()
	if(action.targetOptions.size()):
		var r = randi()%action.targetOptions.size()
		var target = action.targetOptions[r]
		target = actionMenu.ProtectStanceCheck(action, target)
	
		action.Init(self, target)