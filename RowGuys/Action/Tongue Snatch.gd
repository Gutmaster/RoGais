extends "Action.gd"


func _ready():
	animation = "TongueSnatch"
	userRows = [combatNode.ROW.back, combatNode.ROW.middle, combatNode.ROW.front]
	apCost = 3
	atkMod = -1
	keyFrame = 1


func Execute():
	CombatMath(user, target)


func _process(delta):
	if(phase == 1):
		if(user.frame >= keyFrame):
			user.playing = false
			projectile = combatNode.get_node("EffectCatalogue/Tongue").duplicate()
			combatNode.add_child(projectile)
			projectile.Init(user, target)
			phase = 2
	elif(phase == 2):
		if(!projectile.get_node("Tween").is_active()):
			Execute()
			if(target.hp > 0):
				ActionShift(target, !target.teamLeft, 0.2)
			phase = 3
	elif(phase == 3):
		if(projectile == null):
			user.playing = true
			actionMenu.ActionFinished(self)


func FindTargetOptions(var enemyTeam):
	targetOptions.clear()
	for i in range(uList.get_child_count()):
		if(uList.get_child(i).team == enemyTeam):
			if(uList.get_child(i).rowRef != enemyTeam.rpos.front):
				targetOptions.push_back(uList.get_child(i))