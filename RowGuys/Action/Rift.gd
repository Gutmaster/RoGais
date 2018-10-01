extends "Action.gd"


func _ready():
	animation = "Summon"
	userRows = [combatNode.ROW.front, combatNode.ROW.middle, combatNode.ROW.back]
	targetWholeRows = [combatNode.ROW.front, combatNode.ROW.middle, combatNode.ROW.back]
	targetWholeFriendlyRows = [combatNode.ROW.front, combatNode.ROW.middle, combatNode.ROW.back]
	apCost = 4
	keyFrame = 3
	tags.fire = true
	tags.spec = true
	set_process(true)
	descript[0] = "1. Opens a magma rift below a target row, causing damage at upkeep."
	descript[1] = "2. Deals damage to all units in target row when summoned."


func _process(delta):
	if(phase == 1):
		if(user.frame >= keyFrame):
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
	user.SFXPlay(user.SFX.fbtravel)
	user.UpdateAP(-apCost)
	
	for i in range(user.terrainList.size()):
		if(user.terrainList[i] == target.terrain):
			user.terrainList.remove(i)
	
	target.ClearTerrain()
	target.terrain = combatNode.get_node("TerrainCatalogue/Magma Rift").duplicate()
	target.add_child(target.terrain)
	target.terrain.level = level
	target.terrain.Init(target.left, user, self)
	
	user.terrainList.push_back(target.terrain)
	
	if(level >= 2):
		var tArray = target.FindOccupants()
		for i in range(tArray.size()):
			CombatMath(user, tArray[i])