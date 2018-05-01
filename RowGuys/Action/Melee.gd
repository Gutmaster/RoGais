extends "Action.gd"


func _ready():
	userRows = [combatNode.ROW.front]
	animation = "Toss"
	apCost = 2
	tags.melee = true


func _process(delta):
	if(phase == 1):
		if(user.frame+1 >= user.frames.get_frame_count(animation)):
			Execute()
			actionMenu.ActionFinished()


func FindTargetOptions(var team):
	MeleeTargets(team)