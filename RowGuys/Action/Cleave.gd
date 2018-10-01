extends "Action.gd"


func _ready():
	animation = "Melee"
	userRows = [combatNode.ROW.front]
	targetWholeRows = [combatNode.ROW.front]
	apCost = 4
	set_process(true)
	descript[0] = "1. A large slice that damages every unit in the front row."


func Init(usr, trgt, free = false):
	MeleeInit(usr, trgt, free)


func _process(delta):
	if(phase == 1):
		if(user.frame+1 >= user.frames.get_frame_count(animation)):
			Execute()
			actionMenu.ActionFinished(self)


func FindTargetOptions(var team):
	targetOptions.clear()
	targetOptions.push_back(team.rpos.front)


func Execute():
	user.SFXPlay(user.SFX.melee)
	user.UpdateAP(-apCost)
	
	var loopo = true
	while(loopo):
		loopo = false
		for i in range(uList.get_child_count()):
			var unit = uList.get_child(i)
			if(unit.rowRef == target && unit.checkFlag == false):
				loopo = true
				unit.checkFlag = true
				CombatMath(user, unit)
				break
	
	for i in range(uList.get_child_count()):
		uList.get_child(i).checkFlag = false