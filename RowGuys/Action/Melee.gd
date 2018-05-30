extends "Action.gd"


func _ready():
	userRows = [combatNode.ROW.front]
	targetRows = [combatNode.ROW.front]
	animation = "Melee"
	apCost = 2
	tags.melee = true


func _process(delta):
	if(phase == 1):
		if(user.frame+2 >= user.frames.get_frame_count(animation)):
			Execute()
			actionMenu.ActionFinished(self)