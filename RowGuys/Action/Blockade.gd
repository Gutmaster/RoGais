extends "Action.gd"


func _ready():
	animation = "Blockade"
	userRows = [combatNode.ROW.front, combatNode.ROW.middle, combatNode.ROW.back]
	targetWholeRows = [combatNode.ROW.back]
	
	apCost = 5
	set_process(true)


func _process(delta):
	if(phase == 1):
		if(user.frame+1 >= user.frames.get_frame_count(animation)):
			Execute()
			actionMenu.ActionFinished(self)


func FindTargetOptions(var team):
	targetOptions.clear()
	targetOptions.push_back(team.enemy.rpos.back)


func Execute():
	user.UpdateAP(-apCost)
	
	target.ClearTerrain()
	target.terrain = combatNode.get_node("TerrainCatalogue/Earth Barrier").duplicate()
	target.add_child(target.terrain)
	target.terrain.Init(target.left)
	user.terrainList.push_back(target.terrain)
	
	var tList = target.FindOccupants()

	for i in range(tList.size()):
		CombatMath(user, tList[i], false)
		if(tList[i].alive):
			tList[i].Shift(tList[i].PickRandShiftDir(), 0.4, "Stagger", "Stagger")