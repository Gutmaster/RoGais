extends "Action.gd"


func _ready():
	userRows = [combatNode.ROW.front]
	animation = "Toss"
	apCost = 4
	tags.fire = true


func UseCheck():
	if(combatNode.activeUnit.stats.ap < apCost):
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
		projectile = combatNode.get_node("EffectCatalogue/Fireball").duplicate()
		combatNode.add_child(projectile)
		projectile.Init(user, target)
		ActionShift(true if user.team == combatNode.get_node("TeamLeft") else false)
		phase = 2
	if(phase == 2):
		if(user.frame+1 >= user.frames.get_frame_count(animation) && !user.shifting):
			phase = 3
	if(phase == 3):
		if(projectile && !projectile.get_node("Tween").is_active()):
			Execute()
			actionMenu.ActionFinished()


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
				uList.get_child(i).UpdateHP(-(4 - (uList.get_child(i).stats.Endurance + uList.get_child(i).stance.mod.Endurance)))
				break