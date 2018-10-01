extends "Action.gd"


func _ready():
	animation = "Toss"
	userRows = [combatNode.ROW.front]
	targetRows = [combatNode.ROW.middle, combatNode.ROW.front]
	apCost = 2
	keyFrame = 3
	descript[0] = "1. Taunt an enemy into using a standard melee attack on this unit during their next turn"


func _process(delta):
	if(phase == 1):
		if(user.frame >= keyFrame):
			user.SFXPlay(user.SFX.hit)
			Execute()
			actionMenu.ActionFinished(self)


func Execute():
	target.taunter = user