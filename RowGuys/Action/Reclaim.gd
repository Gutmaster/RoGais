extends "Action.gd"


func _ready():
	userRows = [combatNode.ROW.front]
	targetRows = [combatNode.ROW.front]
	animation = "Melee"
	apCost = 4
	tags.melee = true


func RangedUpgrade():
	userRows = [combatNode.ROW.front, combatNode.ROW.middle, combatNode.ROW.back]
	targetRows = [combatNode.ROW.front, combatNode.ROW.middle, combatNode.ROW.back]
	animation = "GreenMagic"
	tags.melee = false
	level = 2
	SetInfo()


func _process(delta):
	if(phase == 1):
		if(user.frame+1 >= user.frames.get_frame_count(animation)):
			Execute()
			actionMenu.ActionFinished(self)


func Execute():
	target.TempPlay("Stagger")
	CombatMath(user, target)
	if(target.hp <= 0):
		get_node("/root/Globals").party.food += 5