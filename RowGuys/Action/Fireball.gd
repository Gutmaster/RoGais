extends "Action.gd"


func _ready():
	animation = "Toss"
	userRows = [combatNode.ROW.back, combatNode.ROW.middle, combatNode.ROW.front]
	targetRows = [combatNode.ROW.back, combatNode.ROW.middle, combatNode.ROW.front]
	apCost = 3
	tags.spec = true
	tags.fire = true
	keyFrame = 3
	descript[0] = "1. Lobs a fireball at another unit."


func _process(delta):
	if(phase == 1):
		if(user.frame >= keyFrame):
			user.SFXPlay(user.SFX.fbtravel)
			projectile = combatNode.get_node("EffectCatalogue/Fireball").duplicate()
			combatNode.add_child(projectile)
			projectile.Init(user, target)
			phase = 2
	elif(phase == 2):
		if(!projectile.get_node("Tween").is_active()):
			user.SFXPlay(user.SFX.fbhit)
			Execute()
			actionMenu.ActionFinished(self)