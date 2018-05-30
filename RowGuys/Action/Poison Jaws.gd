extends "Action.gd"


func _ready():
	userRows = [combatNode.ROW.front]
	targetRows = [combatNode.ROW.front]
	animation = "PoisonBite"
	apCost = 3
	effectPower = 5
	tags.melee = true


func _process(delta):
	if(phase == 1):
		if(user.frame+1 >= user.frames.get_frame_count(animation)):
			Execute()
			actionMenu.ActionFinished(self)


func Execute():
	target.TempPlay("Stagger")
	target.Poison(effectPower)
	CombatMath(user, target)