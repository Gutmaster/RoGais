extends "Action.gd"


func _ready():
	userRows = [combatNode.ROW.front]
	animation = "FireCrackerFlip"
	apCost = 4
	atkMod = 4
	tags.fire = true


func UseCheck():
	if(combatNode.activeUnit.ap < apCost):
		return false
	
	if(combatNode.activeUnit.team.rpos.middle.terrain.tags.blocking):
		return false
	
	if(combatNode.activeUnit.rowRef.terrain.tags.trapping):
		return false
		
	for i in range(userRows.size()):
		if(combatNode.activeUnit.row == userRows[i]):
			return true
	
	return false


func _process(delta):
	if(phase == 1):
		projectile = combatNode.get_node("EffectCatalogue/Firecracker").duplicate()
		combatNode.add_child(projectile)
		projectile.Init(user, target)
		projRef = weakref(projectile)
		ActionShift(user, user.teamLeft)
		phase = 2
	if(phase == 2):
		if(!user.shifting):
			phase = 3
	if(phase == 3):
		if(projRef.get_ref() && !projectile.get_node("Tween").is_active()):
			Execute()
			actionMenu.ActionFinished(self)


func FindTargetOptions(var team):
	targetOptions.clear()
	targetOptions.push_back(team.rpos.front)


func Execute():
	user.UpdateAP(-apCost)
	var loopo = true
	while(loopo):
		loopo = false
		for i in range(uList.get_child_count()):
			if(uList.get_child(i).rowRef == target && uList.get_child(i).checkFlag == false):
				loopo = true
				uList.get_child(i).checkFlag = true
				uList.get_child(i).TempPlay("Stagger")
				uList.get_child(i).UpdateHP(-(atkMod - uList.get_child(i).aStats.Endurance))
				break