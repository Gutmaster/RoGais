extends "Action.gd"


func _ready():
	tags.targeted = false
	userRows = [combatNode.ROW.back, combatNode.ROW.middle, combatNode.ROW.front]
	animation = "GreenMagic"
	apCost = 3


func _process(delta):
	if(phase == 1):
		if(user.frame+1 >= user.frames.get_frame_count(animation)):
			Execute()
			actionMenu.ActionFinished(self)


func Execute():
	var beast = load("res://Unit/Pangolin/Pangolin.tscn").instance()
	combatNode.AddTempUnit(beast, combatNode.SIDE.left, true, user.row)
	if(level >= 2):
		beast.aStats.Vitality += 1
		beast.hp += 1
		beast.aStats.Endurance += 1
	combatNode.SetUnitPos()
	combatNode.get_node("HUD/Queue").QueuePredict()