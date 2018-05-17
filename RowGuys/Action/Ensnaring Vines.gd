extends "Action.gd"


func _ready():
	animation = "GreenMagic"
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
	
	target.terrain = combatNode.get_node("TerrainCatalogue/Ensnaring Vines").duplicate()
	target.add_child(target.terrain)
	target.terrain.Init(target.left)