extends Control


const critChance = 0.1

var level = 1

var userRows = []
var targetRows = []

var targetOptions = []
var targets = []
var user
var target

var animation = null
var projectile = null
var projRef = null

var tags = {"spec": false, "melee": false, "ranged": false, "fire": false, "targeted": true}

signal finished
var phase = 0
var keyFrame = 0

var apCost
var atkMod = 0
var effectPower = 0
var critMod = 1

onready var combatNode = get_node("/root/Globals").combatScene
onready var actionMenu = combatNode.get_node("HUD/CommandWindow/VBoxContainer/ActionButton")

onready var uList = combatNode.get_node("UnitList")


func _ready():
	set_process(false)


func UseCheck():
	if(combatNode.activeUnit.ap < apCost):
		return false
		
	for i in range(userRows.size()):
		if(combatNode.activeUnit.row == userRows[i]):
			return true
	
	return false


func FindTargetOptions(var team):
	targetOptions.clear()
	for i in range(uList.get_child_count()):
		if(uList.get_child(i).team == team):
			for j in range(targetRows.size()):
				if(uList.get_child(i).row == targetRows[j]):
					targetOptions.push_back(uList.get_child(i))


func CombatMath(var user, var target):
	var dmg
	if(tags.spec):
		dmg = user.aStats.Wisdom - target.aStats.Willpower
	else:
		dmg = user.aStats.Strength - target.aStats.Endurance
	
	dmg += atkMod
	
	if(critCheck()):
		print("crit ", dmg, "x ", critMod)
		dmg *= 2
		print(dmg)
	target.CombatDamage(user, dmg)


func Init(usr, trgt, free = false):
	user = usr
	target = trgt
	if(!free):
		user.UpdateAP(-apCost)
	phase = 1
	user.cAction = self
	set_process(true)
	user.TempPlay(animation)


func MeleeInit(usr, trgt, free):
	user = usr
	target = trgt
	if(!free):
		user.UpdateAP(-apCost)
	phase = 1
	user.cAction = self
	set_process(true)
	user.TempPlay(animation)
	
	usr.lastPos = usr.position
	
	var side
	if(usr.teamLeft):
		side = -1
	else:
		side = 1
	
	usr.get_node("MeleeTween").interpolate_property(usr, "position", usr.position, trgt.position + Vector2(side * trgt.width/2, 0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	usr.get_node("MeleeTween").start()


func Execute():
	target.TempPlay("Stagger")
	CombatMath(user, target)


func critCheck():
	if(tags.fire && user.flags.fireCrit):
		return true 
		
	randomize()
	var a = randi()%10+1
	var b = critChance*critMod*10
	print(a, b)
	if(a <= b):
		return true
	
	return false


func ActionShift(var left, var speed = 0.5):
	if(user.team == combatNode.get_node("TeamLeft")):
		if(left):
			if(user.row == user.ROW.front):
				user.rowRef = user.team.rpos.middle
				user.row = user.ROW.middle
			elif(user.row == user.ROW.middle):
				user.rowRef = user.team.rpos.back
				user.row = user.ROW.back
		else:
			if(user.row == user.ROW.back):
				user.rowRef = user.team.rpos.middle
				user.row = user.ROW.middle
			elif(user.row == user.ROW.middle):
				user.rowRef = user.team.rpos.front
				user.row = user.ROW.front
	else:
		if(left):
			if(user.row == user.ROW.back):
				user.rowRef = user.team.rpos.middle
				user.row = user.ROW.middle
			elif(user.row == user.ROW.middle):
				user.rowRef = user.team.rpos.front
				user.row = user.ROW.front
		else:
			if(user.row == user.ROW.front):
				user.rowRef = user.team.rpos.middle
				user.row = user.ROW.middle
			elif(user.row == user.ROW.middle):
				user.rowRef = user.team.rpos.back
				user.row = user.ROW.back
	
	user.shifting = true
		
	user.get_node("Tween").interpolate_property(user, "position", user.position, user.rowRef.position - Vector2(0, user.Size().y/3) + user.rowRef.get_node("UnitLine").get_point_position(user.partyIndex), speed, Tween.TRANS_LINEAR, Tween.EASE_IN)
	user.get_node("Tween").start()


func TargetedShift(unit, target, speed = 0.5, animB = "ShiftBack", animF = "ShiftForward"):
	if(unit.rowRef.terrain.tags.trapping):
		unit.shifting = false
		return
	
	if(unit.rowRef.left != target.left):
		unit.TempPlay(animF)
	elif(target.row > unit.row):
		unit.TempPlay(animB)
	else:
		unit.TempPlay(animF)
	
	unit.rowRef = target
	unit.row = unit.rowRef.row
	
	unit.shifting = true
	
	unit.get_node("Tween").interpolate_property(unit, "position", unit.position, unit.rowRef.position - Vector2(0, unit.height/3) + unit.rowRef.get_node("UnitLine").get_point_position(unit.partyIndex), speed, Tween.TRANS_LINEAR, Tween.EASE_IN)
	unit.get_node("Tween").start()