extends "Action.gd"


func _ready():
	userRows = [combatNode.ROW.middle]
	targetRows = [combatNode.ROW.front]
	animation = "LeapingStrike"
	apCost = 3
	atkMod = 1
	keyFrame = 3
	tags.melee = true


func Init(usr, trgt, free = false):
	MeleeInit(usr, trgt, free)
	user.rowRef = user.team.rpos.front
	user.row = user.ROW.front
	user.lastPos = user.rowRef.position - Vector2(0, user.Size().y/3) + user.rowRef.get_node("UnitLine").get_point_position(user.partyIndex)


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
		#ActionShift(false if user.team == combatNode.get_node("TeamLeft") else true)
		phase = 2
	elif(phase == 2):
		if(user.frame >= keyFrame):
			Execute()
			actionMenu.ActionFinished(self)