extends "Action.gd"

func _ready():
	animation = "TongueSnatch"
	userRows = [combatNode.ROW.back, combatNode.ROW.middle, combatNode.ROW.front]
	apCost = 3
	atkMod = -1


func _process(delta):
	if(phase == 1):
		if(user.frame+1 >= user.frames.get_frame_count(animation)):
			projectile = combatNode.get_node("EffectCatalogue/Tongue").duplicate()
			combatNode.add_child(projectile)
			projectile.Init(user, target)
			phase = 2
	elif(phase == 2):
		if(!projectile.get_node("Tween").is_active()):
			Execute()
			if(target.hp > 0):
				target.Shift(target.team.side != target.team.SIDE.left, 0.2, "Stagger", "Stagger")
			phase = 3
	elif(phase == 3):
		if(projectile == null):
			actionMenu.ActionFinished()


func FindTargetOptions(var enemyTeam):
	targetOptions.clear()
	for i in range(uList.get_child_count()):
		if(uList.get_child(i).team == enemyTeam):
			if(uList.get_child(i).rowRef != enemyTeam.rpos.front):
				targetOptions.push_back(uList.get_child(i))