extends "Action.gd"


func _ready():
	userRows = [combatNode.ROW.front]
	targetRows = [combatNode.ROW.front]
	animation = "Melee"
	apCost = 3
	tags.melee = true


func _process(delta):
	if(phase == 1):
		if(user.frame+2 >= user.frames.get_frame_count(animation)):
			Execute()
			actionMenu.ActionFinished(self)


func Execute():
	randomize()
	var choice = randi()%2
	var lz
	if(target.team.side == combatNode.SIDE.left):
		if(choice == 1):
			lz = combatNode.find_node("LB") 
		else:
			lz = combatNode.find_node("LM")
			
	if(target.team.side == combatNode.SIDE.right):
		if(choice == 1):
			lz = combatNode.find_node("RB") 
		else:
			lz = combatNode.find_node("RM")
			
	TargetedShift(target, lz, 1, "Stagger", "Stagger")
	CombatMath(user, target)