extends Node2D


enum ROW{
front,
middle,
back}

enum SIDE{
left,
right}

var initialized = false
var activeUnit
var hoverUnit = null
var approaching = false
var midBattle = false
var AIWait = false
var xp = 0
var gold = 0
var itemVal = 0

onready var SFX = {"victory": load("res://SFX/Victory.wav")}

onready var globals = get_node("/root/Globals")
onready var combatNode = globals.combatScene
onready var party = globals.party

onready var uList = get_node("UnitList")


func _ready():
	initialized = true
	LoadCombat(globals.party.get_node("Units"), globals.enemyParty.get_node("Units"))


func _on_Combat_tree_entered():
	if(initialized && !midBattle):
		LoadCombat(globals.party.get_node("Units"), globals.enemyParty.get_node("Units"))


func LoadCombat(var PartyLeft, var PartyRight):
	while(PartyLeft.get_child_count()):
		AddUnit(PartyLeft.get_child(0), SIDE.left)
		
	while(PartyRight.get_child_count()):
		PartyRight.get_child(0).Init()
		AddUnit(PartyRight.get_child(0), SIDE.right, true)
	
	for i in range(uList.get_child_count()):
		print(uList.get_child(i).get_name())
	
	SetUnitPos()
	activeUnit = uList.get_child(0)
	$HUD/Queue.Init()
	$HUD/CommandWindow.Init()
	
	party.DisableSlots()
	
	midBattle = true
	globals.ReParentParty(self)
	party.get_node("HUD").hide()
	#globals.enemyParty.get_node("HUD").visible = true
	#globals.ReParentParty(self, globals.enemyParty)
	
	set_process(true)


func SetUnitPos():
	get_node("TeamLeft").teamIndex = 0
	get_node("TeamRight").teamIndex = 0
	for i in range(uList.get_child_count()):
		var temp = uList.get_child(i)
		temp.partyIndex = temp.team.teamIndex
		temp.team.teamIndex += 1
	var count = combatNode.get_node("TeamLeft").teamIndex
	
	for j in range(get_node("Row").get_child_count()/2):
		get_node("Row").get_child(j).SetLine(combatNode.get_node("TeamLeft"))
	for j in range(3, get_node("Row").get_child_count()):
		get_node("Row").get_child(j).SetLine(combatNode.get_node("TeamRight"))
	
	for i in range(uList.get_child_count()):
		var temp = uList.get_child(i)
		if(temp.row == ROW.back):
			temp.rowRef = temp.team.rpos.back
			temp.position = temp.team.rpos.back.position + temp.team.rpos.back.get_child(0).get_point_position(temp.partyIndex)
		elif(temp.row == ROW.middle):
			temp.rowRef = temp.team.rpos.middle
			temp.position = temp.team.rpos.middle.position + temp.team.rpos.middle.get_child(0).get_point_position(temp.partyIndex)
		elif(temp.row == ROW.front):
			temp.rowRef = temp.team.rpos.front
			temp.position = temp.team.rpos.front.position + temp.team.rpos.front.get_child(0).get_point_position(temp.partyIndex)
		temp.position -= Vector2(0, temp.height/3)


func _process(delta):
	AIWait = false
	for i in range(uList.get_child_count()):
		if(uList.get_child(i).AIWait):
			print(uList.get_child(i).get_name())
			AIWait = true
			break
	if(activeUnit.AI && !AIWait):
		if(!activeUnit.shifting && activeUnit.cAction == null && !activeUnit.is_in_group("Approach")):
			activeUnit.AICommand()
	
	
	var battlewin = true
	var battleloss = true
	for i in range(uList.get_child_count()):
		if(uList.get_child(i).team == get_node("TeamRight")):
			battlewin = false
		if(uList.get_child(i).team == get_node("TeamLeft")):
			battleloss = false
	if(battlewin):
		GoToRewards()
	elif(battleloss):
		get_node("EndScreen/Loss").show()
		set_process(false)


func PassTurn():
	get_node("HUD/CommandWindow").hide()
	$HUD/Queue.Update()
	activeUnit.Upkeep()
	
	if(!activeUnit.AI):
		get_node("HUD/CommandWindow").Init()


func Advance(targetTeam):
	$HUD/CommandWindow.hide()
	$Row.hide()
	for i in range(uList.get_child_count()):
		var unit = uList.get_child(i)
		unit.SFXPlay(unit.SFX.footsteps)
		if(unit.team == targetTeam):
			if(targetTeam == $TeamLeft):
				unit.Shift(false, 0.5, unit.animation, unit.animation, true)
			else:
				unit.Shift(true, 0.5, unit.animation, unit.animation, true)
		else:
			if(unit.rowRef.terrain.tags.trapping):
				if(targetTeam == $TeamLeft):
					unit.Shift(false, 0.5, unit.animation, unit.animation, true)
				else:
					unit.Shift(true, 0.5, unit.animation, unit.animation, true)
			else:
				unit.lastAnim = unit.animation
				unit.play("Stagger")
				unit.add_to_group("Approach")
	
	$Background.scrollDir = targetTeam.enemy.side
	$ApproachTimer.start()


func _on_ApproachTimer_timeout():
	$HUD/CommandWindow.show()
	$HUD/CommandWindow/Advance.Check()
	$Row.show()
	var units = get_tree().get_nodes_in_group("Approach")
	for i in units:
		i.play(i.lastAnim)
		i.remove_from_group("Approach")
	
	var terray = []
	for i in range($Row.get_child_count()):
		terray.push_back($Row.get_child(i).terrain)
		$Row.get_child(i).remove_child($Row.get_child(i).terrain)
		
	for i in range($Row.get_child_count()):
		$Row.get_child(i).terrain.position.x = 0
		if($Background.scrollDir == SIDE.right):
			if(i > 0):
				$Row.get_child(i).SwapTerrain(terray[i-1])
			else:
				$Row.get_child(i).ClearTerrain()
				$Row.get_child(i).terrain.hp = 0
		elif($Background.scrollDir == SIDE.left):
			if(i < 5):
				$Row.get_child(i).SwapTerrain(terray[i+1])
			else:
				$Row.get_child(i).ClearTerrain()
				$Row.get_child(i).terrain.hp = 0
	
	for i in range($Row.get_child_count()):
		print($Row.get_child(i).terrain.get_name())
	$Background.scrollDir = null


func RemoveInfo():
	var anchor = get_node("HUD/UnitInfoAnchor")
	anchor.get_child(0).visible = false
	anchor.remove_child(anchor.get_child(0))


func AddUnit(var unit, var team, var AI = false, var row = unit.defaultRow):
	if(team == SIDE.left):
		unit.team = get_node("TeamLeft")
		unit.add_to_group("Party")
	else:
		if(party.artifactSlot.item != null):
			party.artifactSlot.item.EnemyMod(unit)
		unit.flip_h = true
		unit.team = get_node("TeamRight")
	
	unit.row = row
	unit.AI = AI
	unit.ReParent(uList)


func AddTempUnit(var unit, var team, var AI = true, var row = unit.defaultRow):
	if(team == SIDE.left):
		unit.team = get_node("TeamLeft")
	else:
		unit.flip_h = true
		unit.team = get_node("TeamRight")
	
	unit.Init()
	unit.row = row
	unit.AI = AI
	uList.add_child(unit, true)
	unit.CharCardInit()
	globals.party.get_node("HUD/VBoxContainer/HBoxContainer/Unit Cards").add_child(unit.quickStats)


func GoToRewards():
	SFXPlay(SFX.victory)
	$HUD/CommandWindow.hide()
	$EndScreen/RewardScreen.Init(xp, gold, itemVal)
	set_process(false)


func EndBattle():
	var loopo = true
	while(loopo):
		loopo = false
		for i in range(uList.get_child_count()):
			var unit = uList.get_child(i)
			unit.ChangeStance(unit.FindStance("Wait"))
			unit.UpdateAP(unit.aStats.Stamina)
			unit.rowRef = null
			if(unit.AI):
				unit.ReParent($Deadzone)
				loopo = true
				break;
	
	for i in range($Row.get_child_count()):
		print($Row.get_child(i).get_name())
		$Row.get_child(i).SetTerrain(get_node("TerrainCatalogue/Default").duplicate())
	
	$Deadzone.Dump()
	
	$HUD/Queue.Clear()
	
	midBattle = false
	#remove_child(globals.enemyParty)
	globals.LoadUnitsFromBattle(uList)
	globals.ReParentParty(globals.prevScene)
	party.get_node("HUD").show()
	globals.ChangeScene(globals.prevScene)
	
	xp = 0
	gold = 0
	itemVal = 0


func _on_Combat_tree_exited():
	pass


func SFXPlay(sfx):
	$SFX.stream = sfx
	$SFX.play()