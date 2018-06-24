extends "Action.gd"


func _ready():
	userRows = [combatNode.ROW.front]
	targetRows = [combatNode.ROW.front]
	animation = "Toss"
	apCost = 5
	keyFrame = 3
	tags.melee = true


func Init(usr, trgt, free = false):
	MeleeInit(usr, trgt, free)


func _process(delta):
	if(phase == 1):
		print(user.frame)
		if(user.frame >= keyFrame):
			Execute()
			actionMenu.ActionFinished(self)


func Execute():
	CombatMath(user, target)
	target.TempPlay("Stagger")
	combatNode.get_node("HUD/Queue").PushBack(target, 1)