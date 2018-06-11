extends AnimatedSprite


var QSScene = load("res://Party/QuickStats/QuickStats.tscn")
var quickStats

var PCScene = load("res://Party/MiniPartyCard.tscn")
var partyCard

#var MPCScene = load("res://Party/MiniPartyCard.tscn")
#var miniPartyCard

enum ROW{
front,
middle,
back}

enum ANIMFLAG{
temp,
command,
passturn,
action,
next,
stanceChange}

enum STATUS{
normal,
poison,
marked}

var animFlag = null
var animQueue = []

var lastPos = Vector2(0,0)
var tweenBack = false

var status = []

var idName
var portrait = null

var AI = false
var AIAction = false
var AIShift = false

var team = null
var teamLeft = false

var defaultRow
var row
var rowRef = null

var shifting = false
var checkFlag = false
var animAtkFlag = false

var mouseHover = false
var color = Color(1,1,1,1)

var height
var width

var eatFlag = true
var starveLvl = 0
var starveNerf = {"Vitality" : 0, "Stamina" : 0, "Strength" : 0, "Wisdom" : 0, "Endurance" : 0, "Willpower" : 0, "Speed" : 0}

var partyIndex = 0

var initiative = 0
var qInitiative = 0
var bStats = {"Vitality" : 1, "Stamina" : 1, "Strength" : 1, "Wisdom" : 1, "Endurance" : 1, "Willpower" : 1, "Speed" : 1}
var mStats = {"Vitality" : 0, "Stamina" : 0, "Strength" : 0, "Wisdom" : 0, "Endurance" : 0, "Willpower" : 0, "Speed" : 0}
var aStats = {"Vitality" : 0, "Stamina" : 0, "Strength" : 0, "Wisdom" : 0, "Endurance" : 0, "Willpower" : 0, "Speed" : 0}


var hp = 0
var ap = 0
var xp = 0
var xpReq = 0
var flags = {"fireCrit": false}

var lastAnim = null
var tempPlay = false
var nextAnim
var cAction

var terrainList = []

var actionList = []
var stanceList = []
onready var stance = get_node("StanceCatalogue/Wait")
onready var nextStance = null

var skillTree = null

onready var globals = get_node("/root/Globals")
onready var combatNode = globals.combatScene
onready var actionMenu = combatNode.get_node("HUD/CommandWindow/VBoxContainer/ActionButton")
onready var party = globals.party

var trinket1 = null
var trinket2 = null


func _ready():
	NormPlay("Idle")


func SharedInit():
	portrait = load("res://Unit/" + idName + "/Portrait.png")
	height = frames.get_frame("Idle", 0).get_size().y
	width = frames.get_frame("Idle", 0).get_size().x
	
	RefreshStats()
	hp = aStats.Vitality
	ap = aStats.Stamina
	
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
	
	trinket1 = partyCard.find_node("TrinketSlot")
	trinket2 = partyCard.find_node("TrinketSlot2")


func MiniPartyCardInit():
	pass
	#miniPartyCard = MPCScene.instance()
	
	#miniPartyCard.find_node("Name").set_text(get_name())
	#miniPartyCard.find_node("Portrait").texture = portrait

	#miniPartyCard.unit = self


func _process(delta):
	HoverMod()


func Upkeep():
	TerrainUpkeep()
	StatusCheck()
	StanceBonus()
	if(teamLeft && party.artifactContainer.get_child(0) != null):
		party.artifactContainer.get_child(0).Upkeep(self)
	if(trinket1 != null && trinket1.item != null):
		trinket1.item.Upkeep(self)
	if(trinket2 != null && trinket2.item != null):
		trinket2.item.Upkeep(self)
	if(get_name() == "Dank Druid"):
		Growth()
	RefreshStats()
	UpdateAP(ceil(float(aStats.Stamina)/2))
	#for i in range(combatNode.get_node("Row").get_child_count()):
		#combatNode.get_node("Row").get_child(i).Decay()


func TerrainUpkeep():
	var dump = []
	for i in range(terrainList.size()):
		if(!terrainList[i].Upkeep()):
			dump.push_back(i)
	
	for i in range(dump.size()):
		terrainList.remove(dump[i])



func Shift(left, speed = 0.5, animB = "ShiftBack", animF = "ShiftForward", advance = false):
	if(rowRef.terrain.tags.trapping && !advance):
		shifting = false
		return
	if(team == combatNode.get_node("TeamLeft")):
		if(left):
			TempPlay(animB)
			if(row == ROW.front):
				rowRef = team.rpos.middle
				row = ROW.middle
			elif(row == ROW.middle):
				rowRef = team.rpos.back
				row = ROW.back
		else:
			TempPlay(animF)
			if(row == ROW.back):
				rowRef = team.rpos.middle
				row = ROW.middle
			elif(row == ROW.middle):
				rowRef = team.rpos.front
				row = ROW.front
	else:
		if(left):
			TempPlay(animF)
			if(row == ROW.back):
				rowRef = team.rpos.middle
				row = ROW.middle
			elif(row == ROW.middle):
				rowRef = team.rpos.front
				row = ROW.front
		else:
			TempPlay(animB)
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


func CombatDamage(source, dmg):
	for i in range(status.size()):
		if(status[i].type == STATUS.marked && status[i].hunter == source):
			dmg *= 1.5
			print("Marked Bonus", str(dmg))
	
	UpdateHP(-dmg)
	stance.PostAction(self, source)


func UpdateHP(var dif):
	hp += dif
	if(hp > aStats.Vitality):
		hp = aStats.Vitality
	elif(hp < 0):
		hp = 0
		
	$HPChange.Set(dif, Color(1, 0, 0))
	
	if(hp <= 0):
		ReParent(combatNode.get_node("Deadzone"))
		combatNode.SetUnitPos()
		set_visible(false)
		
		if(self.is_in_group("Party")):
			self.remove_from_group("Party")
		
		if(self == combatNode.activeUnit):
			combatNode.PassTurn()
		else:
			combatNode.get_node("HUD/Queue").QueuePredict()


func UpdateAP(var dif):
	ap += dif
	if(ap > aStats.Stamina):
		ap = aStats.Stamina
	elif(ap < 0):
		ap = 0


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
	animQueue.push_back(stance.animation)
	#play(animQueue.back())
	
	RefreshStats()


func QueueChangeStance(stance):
	nextStance = stance
	animFlag = ANIMFLAG.stanceChange


func NormPlay(anim):
	animQueue.push_back(anim)
	play(anim)


func ActionPlay(anim):
	animFlag = ANIMFLAG.action
	play(anim)


func TempPlay(anim):
	animQueue.push_back(anim)
	play(anim)
	animFlag = ANIMFLAG.temp


func QueuePlay(var anim):
	if(animQueue.size() > 1):
		animQueue.insert(size() - 1, anim)
	else:
		print("Cannot insert, array too small")
	#nextAnim = anim
	animFlag = ANIMFLAG.temp


func _on_Unit_animation_finished():
	if(animFlag == ANIMFLAG.command):
		animQueue.resize(1)
		if(!AI):
			combatNode.get_node("HUD/CommandWindow").show()
	elif(animFlag == ANIMFLAG.temp):
		animQueue.pop_back()
	elif(animFlag == ANIMFLAG.stanceChange):
		ChangeStance(nextStance)
	
	play(animQueue.back())
	animFlag = null


func StatusCheck():
	for i in range(status.size()):
		status[i].Upkeep(self)
		
		"""quickStats.find_node("StatusPower").text = str(status[i].power)
		
		if(self.is_in_group("Party")):
			partyCard.find_node("StatusPower").text = str(status[i].power)"""
		
		if(status.size() && status[i].power <= 0):
			status.remove(i)
			"""quickStats.find_node("StatusIcon").texture = null
			quickStats.find_node("StatusPower").text = ""
			
			if(self.is_in_group("Party")):
				partyCard.find_node("StatusIcon").texture = null
				partyCard.find_node("StatusPower").text = ""
"""

func SeekStatus(sts):
	for i in range(status.size()):
		print(status[i].type, sts.type)
		if(status[i].type == sts.type):
			return status[i]
	return sts


func StatusCure():
	quickStats.find_node("StatusIcon").texture = null
	quickStats.find_node("StatusPower").text = ""
	
	if(self.is_in_group("Party")):
		partyCard.find_node("StatusIcon").texture = null
		partyCard.find_node("StatusPower").text = ""
	
	status.clear()
	TempPlay("Defend")


func StanceBonus():
	flags.fireCrit = false
	flags.fireCrit = stance.bonus.fireCrit


func Poison(var power):
	if(power > aStats.Endurance):
		var temp = find_node("Poison").duplicate()
		temp._init()
		var effect = SeekStatus(temp)
		
		if(effect == temp):
			status.push_back(effect)
		
		effect.power += power - aStats.Endurance
		print(effect.power)
		
		quickStats.find_node("Status").add_child(effect)
		
		quickStats.print_tree()


func Mark(hunter):
	var temp = find_node("Marked").duplicate()
	temp.Init(hunter)
	var effect = SeekStatus(temp)
	
	if(effect == temp):
		status.push_back(effect)
		quickStats.find_node("Status").add_child(effect)
		quickStats.print_tree()


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
		if(!AI && combatNode.activeUnit == self):
			combatNode.get_node("HUD/CommandWindow").visible = true
		if(lastAnim != null):
			play(lastAnim)
		else:
			play("Idle")
	else:
		combatNode.get_node("HUD/CommandWindow").rect_position =  position
	
	combatNode.get_node("HUD/CommandWindow/VBoxContainer/ShiftButton").SetOoBShift()
	shifting = false
	$Tween.set_active(false)


func _on_MeleeTween_tween_completed(object, key):
	if(tweenBack):
		tweenBack = false
		return
	
	$MeleeTween.interpolate_property(self, "position", position, lastPos, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$MeleeTween.start()
	tweenBack = true


func Size():
	return frames.get_frame(animation, frame).get_size()


#version for outside of combat
func UpdateHealth(var dif):
	hp += dif
	if(hp > aStats.Vitality):
		hp = aStats.Vitality
	elif(hp < 0):
		hp = 0
		
	if(hp <= 0):
		queue_free()


func Eat():
	starveLvl -= 1
	if(starveLvl < 0):
		starveLvl = 0


func Starve():
	starveLvl += 1
	starveNerf.Vitality = -starveLvl
	starveNerf.Stamina = -starveLvl
	starveNerf.Strength = -starveLvl
	starveNerf.Wisdom = -starveLvl
	starveNerf.Endurance = -starveLvl
	starveNerf.Willpower = -starveLvl
	starveNerf.Speed = -starveLvl


func Reset(mod):
	mod.Vitality = 0
	mod.Strength = 0
	mod.Endurance = 0
	mod.Stamina = 0
	mod.Willpower = 0
	mod.Wisdom = 0
	mod.Speed = 0


func Addributes(mod):
	mStats.Vitality += mod.Vitality
	mStats.Strength += mod.Strength
	mStats.Endurance += mod.Endurance
	mStats.Stamina += mod.Stamina
	mStats.Willpower += mod.Willpower
	mStats.Wisdom += mod.Wisdom
	mStats.Speed += mod.Speed
	
	ApplyStats()
	
	if(hp > aStats.Vitality):
		hp = aStats.Vitality
	if(ap > aStats.Stamina):
		ap = aStats.Stamina


"""func Subtributes(mod):
	mStats.Vitality -= mod.Vitality
	mStats.Strength -= mod.Strength
	mStats.Endurance -= mod.Endurance
	mStats.Stamina -= mod.Stamina
	mStats.Willpower -= mod.Willpower
	mStats.Wisdom -= mod.Wisdom
	mStats.Speed -= mod.Speed
	
	ApplyStats()
	
	if(hp > aStats.Vitality):
		hp = aStats.Vitality
	if(ap > aStats.Stamina):
		ap = aStats.Stamina"""


func ApplyStats():
	aStats.Vitality = mStats.Vitality
	aStats.Strength = mStats.Strength
	aStats.Endurance = mStats.Endurance
	aStats.Wisdom = mStats.Wisdom
	aStats.Willpower = mStats.Willpower
	aStats.Stamina = mStats.Stamina
	aStats.Speed = mStats.Speed
	
	if(aStats.Vitality < 1):
		aStats.Vitality = 1
	if(aStats.Stamina < 1):
		aStats.Stamina = 1
	if(aStats.Strength < 1):
		aStats.Strength = 1
	if(aStats.Endurance < 1):
		aStats.Endurance = 1
	if(aStats.Wisdom < 1):
		aStats.Wisdom = 1
	if(aStats.Willpower < 1):
		aStats.Willpower = 1
	if(aStats.Speed < 1):
		aStats.Speed = 1


func RefreshStats():
	Reset(mStats)
	Addributes(bStats)
	if(trinket1 != null && trinket1.item != null):
		Addributes(trinket1.item.stats)
	if(trinket2 != null && trinket2.item != null):
		Addributes(trinket2.item.stats)
	if(teamLeft && party != null && party.artifactSlot.item != null):
		Addributes(party.artifactSlot.item.stats)
	if(rowRef != null):
		Addributes(rowRef.terrain.stats)
	if(starveLvl > 0):
		Addributes(starveNerf)
	if(stance != null):
		Addributes(stance.stats)
	
	ApplyStats()


#################AI CODE#########################################
func AIAdvance():
	if(!combatNode.get_node("Row/LF").FindOccupants().size() &&
	   !combatNode.get_node("Row/RB").terrain.tags.trapping):
		combatNode.Advance(combatNode.get_node("TeamLeft"))
		return true
		
	return false


func AIApproach():
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
		AIApproach()
		AIShift = true
	elif(!AIAction):
		AIRandomMelee()
		AIAction = true