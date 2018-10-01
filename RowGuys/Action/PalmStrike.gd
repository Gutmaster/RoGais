extends "Action.gd"


func _ready():
	userRows = [combatNode.ROW.front]
	targetRows = [combatNode.ROW.front]
	animation = "Melee"
	apCost = 3
	keyFrame = 3
	tags.melee = true
	descript[0] = "1. Strikes a unit with decisive force, pushing them back one row."


func SetInfo():
	.SetInfo()
	infoBox.find_node("MoveFM").set_texture(moveRight)


func Init(usr, trgt, free = false):
	targetOptions.clear()
	MeleeInit(usr, trgt, free)


func _process(delta):
	if(phase == 1):
		if(user.frame >= keyFrame):
			Execute()
			actionMenu.ActionFinished(self)


func Execute():
	target.Shift(target.teamLeft, 0.3, "Stagger", "Stagger")
	CombatMath(user, target)