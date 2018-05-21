extends "Action.gd"


func _ready():
	animation = "Blockade"
	userRows = [combatNode.ROW.front, combatNode.ROW.middle, combatNode.ROW.back]
	apCost = 5
	set_process(true)


func _process(delta):
	if(phase == 1):
		if(user.frame+1 >= user.frames.get_frame_count(animation)):
			Execute()
			actionMenu.ActionFinished()


func FindTargetOptions(var team):
	targetOptions.clear()
	targetOptions.push_back(team.enemy.rpos.back)


func Execute():
	user.UpdateAP(-apCost)
	
	target.terrain = combatNode.get_node("TerrainCatalogue/Earth Barrier").duplicate()
	target.add_child(target.terrain)
	target.terrain.Init(target.left)
	
	var tList = target.FindOccupants()

	for i in range(tList.size()):
		tList[i].UpdateHP(-(user.aStats.Strength - tList[i].aStats.Endurance))
		if(tList[i].visible):
			tList[i].Shift(tList[i].PickRandShiftDir(), 0.4, "Toss", "Toss")