extends "Action.gd"


func _ready():
	tags.targeted = false
	userRows = [combatNode.ROW.back, combatNode.ROW.middle, combatNode.ROW.front]
	animation = "Dance"
	apCost = 3


func _process(delta):
	if(phase == 1):
		if(user.frame+1 >= user.frames.get_frame_count(animation)):
			Execute()
			actionMenu.ActionFinished()


func Execute():
	combatNode.AddTempUnit(load("res://Unit/Pangolin/Pangolin.tscn").instance(), combatNode.SIDE.left, true, user.row)
	combatNode.SetUnitPos()
	combatNode.get_node("HUD/Queue").QueuePredict()