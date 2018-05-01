extends "Action.gd"


func _ready():
	userRows = [combatNode.ROW.front]
	animation = "Toss"
	apCost = 5
	tags.melee = true


func _process(delta):
	if(phase == 1):
		if(user.frame+1 >= user.frames.get_frame_count(animation)):
			Execute()
			actionMenu.ActionFinished()


func FindTargetOptions(var team):
	MeleeTargets(team)


func Execute():
	CombatMath(user, target)
	target.TempPlay("Stagger")
	target.initiative -= user.stats.Strength
	combatNode.get_node("HUD/Queue").QueuePredict()