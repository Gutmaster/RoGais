extends "Action.gd"


func _ready():
	userRows = [combatNode.ROW.front]
	targetRows = [combatNode.ROW.front]
	animation = "PoisonBite"
	apCost = 3
	effectPower = 5
	keyFrame = 2
	tags.melee = true


func Init(usr, trgt, free = false):
	MeleeInit(usr, trgt, free)


func _process(delta):
	if(phase == 1):
		if(user.frame >= keyFrame):
			Execute()
			actionMenu.ActionFinished(self)


func Execute():
	target.TempPlay("Stagger")
	target.Poison(effectPower)
	CombatMath(user, target)