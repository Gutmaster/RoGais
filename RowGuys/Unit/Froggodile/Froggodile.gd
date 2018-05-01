extends "res://Unit/Unit.gd"


func _ready():
	idName = "Froggodile"
	Init()
	
	stats.Stamina = 5
	stats.Speed = 4
	stats.Strength = 3
	stats.Vitality = 4
	stats.hp = stats.Vitality
	stats.ap = stats.Stamina
	
	defaultRow = ROW.back
	
	actionList.push_back(get_node("ActionCatalogue/Tongue Snatch"))
	actionList.push_back(get_node("ActionCatalogue/Poison Jaws"))


func AICmd():
	if(PassCheck()):
		return
		
	if(!AIShift):
		if(team.enemy.rpos.front.FindOccupants().size()):
			AIAdvance()
		AIShift = true
	elif(!AIAction):
		if(rowRef == team.rpos.front and \
		   team.enemy.rpos.front.FindOccupants().size() and \
		   stats.ap >= FindAction("Poison Jaws").apCost):
			AIPoisonJaws()
		elif(stats.ap >= FindAction("Tongue Snatch").apCost):
			AITongueSnatch()
		AIAction = true


func AITongueSnatch():
	var action = FindAction("Tongue Snatch")
	action.set_process(true)
	action.FindTargetOptions(team.enemy)
	
	randomize()
	if(action.targetOptions.size()):
		var target = action.targetOptions[randi()%action.targetOptions.size()]
	
		action.Animate(self, target)
		action.phase = 1
		cAction = action


func AIPoisonJaws():
	var action = FindAction("Poison Jaws")
	action.set_process(true)
	action.FindTargetOptions(team.enemy)
	randomize()
	if(action.targetOptions.size()):
		var r = randi()%action.targetOptions.size()
		var target = action.targetOptions[r]
		target = actionMenu.ProtectStanceCheck(action, target)
	
		action.Animate(self, target)
		action.phase = 1
		cAction = action