extends "Action.gd"


func _ready():
	userRows = [combatNode.ROW.front]
	targetRows = [combatNode.ROW.front]
	animation = "Melee"
	apCost = 2
	keyFrame = 3
	tags.melee = true


func Init(usr, trgt, free = false):
	MeleeInit(usr, trgt, free)


func _process(delta):
	if(phase == 1):
		if(user.frame >= keyFrame):
			Execute()
			actionMenu.ActionFinished(self)