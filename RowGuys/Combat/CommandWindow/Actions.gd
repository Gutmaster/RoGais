extends MenuButton


var targetMode
var target

onready var combatNode = get_node("/root/Globals").combatScene


func _ready():
	get_popup().connect("id_pressed", self, "_on_Action_id_pressed")
	get_popup().add_font_override("font",load("res://Fonts/CommandFont.tres"))


func _process(delta):
	if(targetMode):
		if(target != null):
			TargetCheck(target)
			target = null


func _unhandled_input(event):
	if targetMode and event is InputEventMouseButton \
	and event.button_index == BUTTON_RIGHT:
		AbortAction()


func LoadActions():
	get_popup().clear()
	var activeUnit = combatNode.activeUnit
	
	for i in range(activeUnit.actionList.size()):
		print(activeUnit.actionList[i].get_name())
		get_popup().add_item(activeUnit.actionList[i].get_name(), i)
		
		if(!activeUnit.actionList[i].UseCheck()):
			get_popup().set_item_disabled(i, true)


func TargetCheck(target):
	if(targetMode):
		var user = combatNode.activeUnit
		for i in range(user.cAction.targetOptions.size()):
			if(user.cAction.targetOptions[i] == target):
				TargetSelected(user.cAction, target)


func ActionSelected(action):
	get_parent().get_parent().hide()
	var user = combatNode.activeUnit
	action.FindTargetOptions(user.team.enemy)
	action.set_process(true)
	user.cAction = action
	TargetModeOn()


func NTActionSelected(action):
	get_parent().get_parent().hide()
	var user = combatNode.activeUnit
	action.set_process(true)
	action.Init(user, null)
	disabled = true


func AbortAction():
	TargetModeOff()
	get_parent().get_parent().show()
	var user = combatNode.activeUnit
	user.cAction.set_process(false)
	user.cAction = null


func TargetModeOn():
	targetMode = true
	var user = combatNode.activeUnit
	for i in range(user.cAction.targetOptions.size()):
		user.cAction.targetOptions[i].color = Color(0.6,0.1,0.1,1)


func TargetModeOff():
	targetMode = false
	var user = combatNode.activeUnit
	for i in range(user.cAction.targetOptions.size()):
		user.cAction.targetOptions[i].color = Color(1,1,1,1)


func TargetSelected(action, target):
	TargetModeOff()
	var user = combatNode.activeUnit
	target = ProtectStanceCheck(action, target)
	
	action.Init(user, target)
	combatNode.get_node("HUD/CommandWindow/VBoxContainer/ActionButton").disabled = true


func ActionFinished(action):
	var user = action.user
	#if(!user.AI && user == combatNode.activeUnit):
		#combatNode.get_node("HUD/CommandWindow").visible = true
	
	user.AIAction = true
	action.phase = 0
	action.targets.clear()
	action.target = null
	action.set_process(false)
	user.cAction = null


func ProtectStanceCheck(action, target):
	var uList = combatNode.get_node("UnitList")
	if(action.tags.melee):
		for i in range(uList.get_child_count()):
			if(uList.get_child(i).team == target.team && uList.get_child(i).row == combatNode.ROW.front):
				if(uList.get_child(i).stance == uList.get_child(i).get_node("StanceCatalogue/Protect")):
					return uList.get_child(i)
	
	return target


func _on_Action_id_pressed(ID):
	var action = combatNode.activeUnit.actionList[ID]
	if(action.tags.targeted):
		ActionSelected(action)
	else:
		NTActionSelected(action)
