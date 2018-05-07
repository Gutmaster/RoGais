extends "Action.gd"


func _ready():
	userRows = [combatNode.ROW.middle]
	targetRows = [combatNode.ROW.front]
	animation = "Toss"
	apCost = 3
	atkMod = 1
	tags.melee = true


func UseCheck():
	if(combatNode.activeUnit.ap < apCost):
		return false
	
	if(combatNode.activeUnit.team.rpos.front.terrain.tags.blocking):
		return false
	
	if(combatNode.activeUnit.rowRef.terrain.tags.trapping):
		return false
		
	for i in range(userRows.size()):
		if(combatNode.activeUnit.row == userRows[i]):
			return true
	
	return false


func _process(delta):
	if(phase == 1):
		ActionShift(false if user.team == combatNode.get_node("TeamLeft") else true)
		phase = 2
	elif(phase == 2):
		if(user.frame+1 >= user.frames.get_frame_count(animation) && !user.shifting):
			Execute()
			actionMenu.ActionFinished()