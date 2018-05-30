extends "Action.gd"


func _ready():
	animation = "GreenMagic"
	userRows = [combatNode.ROW.front, combatNode.ROW.middle, combatNode.ROW.back]
	apCost = 4
	set_process(true)


func _process(delta):
	if(phase == 1):
		if(user.frame+1 >= user.frames.get_frame_count(animation)):
			Execute()
			actionMenu.ActionFinished(self)


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
	
	for i in range(user.terrainList.size()):
		if(user.terrainList[i] == target.terrain):
			user.terrainList.remove(i)
	
	target.ClearTerrain()
	target.terrain = combatNode.get_node("TerrainCatalogue/Nature's Blessing").duplicate()
	target.add_child(target.terrain)
	target.terrain.level = level
	target.terrain.Init(target.left)
	
	user.terrainList.push_back(target.terrain)
	user.growthList.push_back(target.terrain)