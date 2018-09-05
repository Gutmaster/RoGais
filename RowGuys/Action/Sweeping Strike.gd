extends "Action.gd"


func _ready():
	animation = "BigSwing"
	userRows = [combatNode.ROW.front, combatNode.ROW.middle, combatNode.ROW.back]
	targetWholeRows = [combatNode.ROW.front]
	apCost = 5
	set_process(true)


func _process(delta):
	if(phase == 1):
		if(user.frame+1 >= user.frames.get_frame_count(animation)):
			Execute()
			actionMenu.ActionFinished(self)


func FindTargetOptions(var userTeam):
	targetOptions.clear()
	targetOptions.push_back(userTeam.enemy.rpos.front)


func Execute():
	user.SFXPlay(user.SFX.melee)
	user.UpdateAP(-apCost)
	
	var loopo = true
	while(loopo):
		loopo = false
		for i in range(uList.get_child_count()):
			if(uList.get_child(i).rowRef == target && uList.get_child(i).checkFlag == false):
				loopo = true
				uList.get_child(i).checkFlag = true
				uList.get_child(i).TempPlay("Stagger")
				uList.get_child(i).UpdateHP(-(user.aStats.Strength - uList.get_child(i).aStats.Endurance))
				break
	
	for i in range(uList.get_child_count()):
		uList.get_child(i).checkFlag = false