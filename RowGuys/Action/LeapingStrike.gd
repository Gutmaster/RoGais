extends "Action.gd"


func _ready():
	userRows = [combatNode.ROW.middle]
	targetRows = [combatNode.ROW.front]
	animation = "LeapingStrike"
	apCost = 3
	atkMod = 1
	keyFrame = 2
	tags.melee = true
	descript[0] = "1. Advance from the middle and strike an enemy."


func SetInfo():
	.SetInfo()
	infoBox.find_node("MoveMF").set_texture(moveRight)


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
		if(user.frame >= keyFrame):
			Execute()
			user.SFXPlay(user.SFX.melee)
			actionMenu.ActionFinished(self)