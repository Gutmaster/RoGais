extends "Action.gd"


func _ready():
	animation = "Dance"
	userRows = [combatNode.ROW.front, combatNode.ROW.middle, combatNode.ROW.back]
	apCost = 7
	set_process(true)


func _process(delta):
	if(phase == 1):
		if(user.frame+1 >= user.frames.get_frame_count(animation)):
			Execute()
			actionMenu.ActionFinished()


func FindTargetOptions(var team):
	targetOptions.clear()
	targetOptions.push_back(team.rpos.front)
	targetOptions.push_back(team.rpos.middle)
	targetOptions.push_back(team.rpos.back)
	targetOptions.push_back(team.enemy.rpos.front)
	targetOptions.push_back(team.enemy.rpos.middle)
	targetOptions.push_back(team.enemy.rpos.back)


func Execute():
	user.UpdateAP(-apCost)
	
	
	target.terrain = combatNode.get_node("TerrainCatalogue/Earth Barrier").duplicate()
	target.add_child(target.terrain)
	target.terrain.Init(target.left)
	
	var loopo = true
	while(loopo):
		loopo = false
		for i in range(uList.get_child_count()):
			if(uList.get_child(i).rowRef == target && uList.get_child(i).checkFlag == false):
				loopo = true
				uList.get_child(i).checkFlag = true
				uList.get_child(i).UpdateHP(-(user.stats.atk - (uList.get_child(i).stats.def + uList.get_child(i).stance.mods.def)))
				uList.get_child(i).Shift(uList.get_child(i).PickRandShiftDir(), "Toss", "Toss")
				break