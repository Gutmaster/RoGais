extends AnimatedSprite


var QSScene = load("res://Party/QuickStats/QuickStats.tscn")
var quickStats

var PCScene = load("res://Party/PartyCard.tscn")
var partyCard

enum ROW{
front,
middle,
back}

enum STATUS{
normal,
poison}

var status = STATUS.normal
var statusMod


var idName
var portrait = null

var AI = false
var AIAction = false
var AIShift = false

var team

var defaultRow
var row
var rowRef

var shifting = false
var checkFlag = false
var animAtkFlag = false

var mouseHover = false
var color = Color(1,1,1,1)

var height
var width

var partyIndex = 0

var initiative = 0
var qInitiative = 0
var stats = {"Vitality" : 4, "Stamina" : 3, "Strength" : 2, "Wisdom" : 2, "Endurance" : 1, "Willpower" : 1, "Speed" : 1, "hp" : 4, "ap": 3, }
var flags = {"fireCrit": false}
var xp = 0
var xpReq = 0

var lastAnim = null
var tempPlay = false
var cAction

var actionList = []
var stanceList = []
onready var stance = get_node("StanceCatalogue/Wait")

onready var combatNode = get_node("/root/Globals").combatScene
onready var actionMenu = combatNode.get_node("HUD/CommandWindow/VBoxContainer/ActionButton")
onready var party = get_node("/root/Globals").party


func _ready():
	pass


func SharedInit():
	portrait = load("res://Unit/" + idName + "/Portrait.png")
	height = frames.get_frame("Idle", 0).get_size().y
	width = frames.get_frame("Idle", 0).get_size().x
	
	actionList.clear()
	actionList.push_back(get_node("ActionCatalogue/Melee"))
	stanceList.push_back(get_node("StanceCatalogue/Wait"))
	stanceList.push_back(get_node("StanceCatalogue/Defend"))


func CharCardInit():
	quickStats = QSScene.instance()
	quickStats.find_node("Name").set_text(get_name())
	quickStats.unit = self


func PartyCardInit():
	partyCard = PCScene.instance()
	partyCard.find_node("Name").set_text(get_name())
	if(defaultRow == back):
		partyCard.find_node("Portrait1").texture_normal = portrait
	elif(defaultRow == middle):
		partyCard.find_node("Portrait2").texture_normal = portrait
	elif(defaultRow == front):
		partyCard.find_node("Portrait3").texture_normal = portrait
	partyCard.unit = self


func EnterCombat():
	pass#combatNode.call_deferred("add_child", quickStats)


func Init():
	pass#portrait = load("res://Unit/" + idName + "/Portrait.png")


func _process(delta):
	AnimCheck()
	HoverMod()


func Upkeep():
	StatusCheck()
	StanceBonus()
	party.artifactContainer.get_child(0).Upkeep(self)
	UpdateAP(ceil(float(stats.Stamina)/2))
	for i in range(combatNode.get_node("Row").get_child_count()):
		combatNode.get_node("Row").get_child(i).Decay()
	if(animation == "Stagger"):
		#lastAnim = "Idle"
		play("Idle")
	else:
		play("Idle")


func Shift(left, speed = 0.5, animB = "ShiftBack", animF = "ShiftForward", advance = false):
	if(rowRef.terrain.tags.trapping && !advance):
		shifting = false
		return
	if(team == combatNode.get_node("TeamLeft")):
		if(left):
			play(animB)
			if(row == ROW.front):
				rowRef = team.rpos.middle
				row = ROW.middle
			elif(row == ROW.middle):
				rowRef = team.rpos.back
				row = ROW.back
		else:
			play(animF)
			if(row == ROW.back):
				rowRef = team.rpos.middle
				row = ROW.middle
			elif(row == ROW.middle):
				rowRef = team.rpos.front
				row = ROW.front
	else:
		if(left):
			play(animF)
			if(row == ROW.back):
				rowRef = team.rpos.middle
				row = ROW.middle
			elif(row == ROW.middle):
				rowRef = team.rpos.front
				row = ROW.front
		else:
			play(animB)
			if(row == ROW.front):
				rowRef = team.rpos.middle
				row = ROW.middle
			elif(row == ROW.middle):
				rowRef = team.rpos.back
				row = ROW.back
	
	shifting = true
	
	$Tween.interpolate_property(self, "position", position, rowRef.position - Vector2(0, height/3) + rowRef.get_node("UnitLine").get_point_position(partyIndex), speed, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	
	combatNode.get_node("HUD/CommandWindow").visible = false


#true = left, false = right
func PickRandShiftDir():
	if(row == ROW.front):
		if(team == combatNode.get_node("TeamLeft")):
			return true
		else:
			return false
	elif(row == ROW.back):
		if(team == combatNode.get_node("TeamLeft")):
			return false
		else:
			return true
	elif(row == ROW.middle):
		if(team == combatNode.get_node("TeamLeft")):
			if(team.rpos.back.terrain.tags.blocking):
				return false
			elif(team.rpos.front.terrain.tags.blocking):
				return true
		else:
			if(team.rpos.back.terrain.tags.blocking):
				return true
			elif(team.rpos.front.terrain.tags.blocking):
				return false
	
	randomize()
	if(randi()%2):
		return true
	else:
		return false


func UpdateHP(var dif):
	stats.hp += dif
	if(stats.hp > stats.Vitality):
		stats.hp = stats.Vitality
	elif(stats.hp < 0):
		stats.hp = 0
		
	$HPChange.Set(dif, Color(1, 0, 0))
	
	if(stats.hp <= 0):
		ReParent(combatNode.get_node("Deadzone"))
		combatNode.SetUnitPos()
		set_visible(false)
		
		if(self == combatNode.activeUnit):
			combatNode.PassTurn()
		else:
			combatNode.get_node("HUD/Queue").QueuePredict()


func UpdateAP(var dif):
	stats.ap += dif
	if(stats.ap > stats.Stamina):
		stats.ap = stats.Stamina
	elif(stats.ap < 0):
		stats.ap = 0


func FindAction(var action):
	for i in range(actionList.size()):
		if(actionList[i].get_name() == action):
			return actionList[i]
			
	print("Action not found.")


func FindStance(var stance):
	for i in range(stanceList.size()):
		if(stanceList[i].get_name() == stance):
			return stanceList[i]
			
	print("Stance not found.")


func ChangeStance(newStance):
	stance.set_process(false)
	newStance.set_process(true)
	stance = newStance
	play(stance.animation)


func TempPlay(var anim):
	lastAnim = animation
	tempPlay = true
	play(anim)


func AnimCheck():
	if(tempPlay && frame+1 >= frames.get_frame_count(animation)):
		play(lastAnim)
		lastAnim = null
		tempPlay = false

func StatusCheck():
	if(status == STATUS.poison):
		UpdateHP(-statusMod)
		statusMod -= 1
		quickStats.find_node("StatusPower").text = str(statusMod)
		partyCard.find_node("StatusPower").text = str(statusMod)
		if(statusMod <= 0):
			status = STATUS.normal
			quickStats.find_node("StatusIcon").texture = null
			quickStats.find_node("StatusPower").text = ""
			
			partyCard.find_node("StatusIcon").texture = null
			partyCard.find_node("StatusPower").text = ""


func StanceBonus():
	flags.fireCrit = false
	flags.fireCrit = stance.bonus.fireCrit


func Poison(var power):
	if(power > stats.Endurance):
		status = STATUS.poison
		statusMod = power - stats.Endurance
		quickStats.find_node("StatusIcon").texture = load("res://Party/QuickStats/Poison.png")
		quickStats.find_node("StatusPower").text = str(statusMod)
		
		partyCard.find_node("StatusIcon").texture = load("res://Party/QuickStats/Poison.png")
		partyCard.find_node("StatusPower").text = str(statusMod)


func ReParent(destination):
	get_parent().remove_child(self)
	destination.add_child(self)


func Clone():
	var clone = duplicate()
	clone.idName = get_name()
	return clone


func HoverMod():
	if(combatNode.hoverUnit == self):
		self_modulate = Color(1,1,0.4,1)
		quickStats.self_modulate = Color(1,1,0.4,1)
	else:
		self_modulate = color
		quickStats.self_modulate = Color(1,1,1,1)


func _on_Tween_tween_completed(object, key):
	if(cAction == null):
		combatNode.get_node("HUD/CommandWindow").visible = true
		play("Idle")
	else:
		combatNode.get_node("HUD/CommandWindow").rect_position =  position
	
	combatNode.get_node("HUD/CommandWindow/VBoxContainer/ShiftButton").SetOoBShift()
	shifting = false
	$Tween.set_active(false)


func Size():
	return frames.get_frame(animation, frame).get_size()


#version for outside of combat
func UpdateHealth(var dif):
	stats.hp += dif
	if(stats.hp > stats.Vitality):
		stats.hp = stats.Vitality
	elif(stats.hp < 0):
		stats.hp = 0
		
	if(stats.hp <= 0):
		queue_free()
#################AI CODE#########################################
func AIAdvance():
	if(row != ROW.front):
		if(team == combatNode.get_node("TeamLeft")):
			Shift(false)
		else:
			Shift(true)
		UpdateAP(-1)


func AIRandomMelee():
	if(row == ROW.front):
		var action = actionList[0]
		action.set_process(true)
		actionList[0].FindTargetOptions(team.enemy)
		randomize()
		if(action.targetOptions.size()):
			var r = randi()%action.targetOptions.size()
			var target = action.targetOptions[r]
			target = combatNode.get_node("HUD/CommandWindow/VBoxContainer/ActionButton").ProtectStanceCheck(action, target)
		
			action.Animate(self, target)
			action.phase = 1
			cAction = action


func PassCheck():
	if(AIShift && AIAction):
		AIShift = false
		AIAction = false
		combatNode.PassTurn()
		return true
	return false


#default run and smash AI as a failsafe
func AICmd():
	if(PassCheck()):
		return
	
	if(!AIShift):
		AIAdvance()
		AIShift = true
	elif(!AIAction):
		AIRandomMelee()
		AIAction = true