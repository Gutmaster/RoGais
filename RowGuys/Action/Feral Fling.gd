extends "Action.gd"

signal unitClicked

var targetUpgrade = false
var target2 = null

func _ready():
	userRows = [combatNode.ROW.front]
	targetRows = [combatNode.ROW.front]
	animation = "Melee"
	apCost = 3
	keyFrame = 3
	tags.melee = true


func Init(usr, trgt, free = false):
	targetOptions.clear()
	if(targetUpgrade):
		for i in range(combatNode.uList.get_child_count()):
			var temp = combatNode.uList.get_child(i)
			if(temp.teamLeft != usr.teamLeft && temp.row != trgt.row):
				targetOptions.push_back(temp)
		for i in range(targetOptions.size()):
			targetOptions[i].get_node("Area2D").connect("unitClicked", self, "Target")
	MeleeInit(usr, trgt, free)


func _process(delta):
	if(phase == 1):
		if(user.frame >= keyFrame):
			if(!targetUpgrade || !targetOptions.size()):
				Execute1()
				actionMenu.ActionFinished(self)
			else:
				phase = 2
				for i in range(combatNode.uList.get_child_count()):
					combatNode.uList.get_child(i).stop()
				user.get_node("MeleeTween").stop(user)
	elif(phase == 3):
		if(!target.get_node("Tween").is_active()):
			Execute2()
			actionMenu.ActionFinished(self)


func Execute1():
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


func Target(targ):
	if(!targetUpgrade || phase != 2 || targ == target):
		return
	
	for i in range(combatNode.uList.get_child_count()):
		combatNode.uList.get_child(i).play()
	
	user.get_node("MeleeTween").resume(user)
	
	target2 = targ
	target.get_node("Tween").interpolate_property(target, "position", target.position, targ.position, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	target.get_node("Tween").start()
	phase = 3


func Execute2():
	CombatMath(user, target)
	CombatMath(user, target2)
	target2.TempPlay("Stagger")
	combatNode.get_node("HUD/Queue").PushBack(target2, 5)
	target.row = target2.row
	target.rowRef = target2.rowRef
	combatNode.SetUnitPos()