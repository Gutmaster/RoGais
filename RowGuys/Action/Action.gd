extends Control


const critChance = 0.1

var userRows = []
var targetRows = []

var targetOptions = []
var targets = []
var user
var target

var animation = null
var projectile = null

var tags = {"spec": false, "melee": false, "ranged": false, "fire": false, "targeted": true}

signal finished
var phase = 0

var apCost
var atkMod = 0
var effectPower = 0
var critMod = 1

onready var combatNode = get_node("/root/Globals").combatScene
onready var actionMenu = combatNode.get_node("HUD/CommandWindow/VBoxContainer/ActionButton")

onready var uList = combatNode.get_node("UnitList")


func _ready():
	set_process(false)
	pass#connect("finished", combatNode.get_node("UnitCommand/Action"), "ActionFinished")


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
	user.UpdateAP(-apCost)
	
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
	target.UpdateHP(-dmg)


func Animate(var usr, var trgt):
	user = usr
	target = trgt
	user.ActionPlay(animation)


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