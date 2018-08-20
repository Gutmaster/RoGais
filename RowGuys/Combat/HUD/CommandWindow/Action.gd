extends TextureButton


var targetMode
var target
onready var targetingCursor = load("res://Combat/HUD/CommandWindow/TargetingCursor.png")

var disS = false
var disI = false

onready var combatNode = get_node("/root/Globals").combatScene
onready var item = get_parent().get_node("Item")
onready var stance = get_parent().get_node("Stance")

func _ready():
	pass


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
	DumpActions()
	var unit = combatNode.activeUnit
	for i in range(unit.actionList.size()):
		var action = unit.actionList[i].duplicate()
		$List.add_child(action)
		action.connect("pressed", self, "ActionPressed", [action])
		if(!action.UseCheck()):
			action.disabled = true
		else:
			action.disabled = false


func DumpActions():
	while($List.get_child_count()):
		$List.remove_child($List.get_child(0))


func TargetCheck(target):
	if(targetMode):
		var user = combatNode.activeUnit
		for i in range(user.cAction.targetOptions.size()):
			if(user.cAction.targetOptions[i] == target):
				TargetSelected(user.cAction, target)
				return


func ActionSelected(action):
	var user = combatNode.activeUnit
	action.FindTargetOptions(user.team.enemy)
	action.set_process(true)
	user.cAction = action
	TargetModeOn()


func NTActionSelected(action):
	var user = combatNode.activeUnit
	action.set_process(true)
	action.Init(user, null)


func AbortAction():
	TargetModeOff()
	disabled = false
	var user = combatNode.activeUnit
	user.cAction.set_process(false)
	user.cAction = null


func TargetModeOn():
	Input.set_custom_mouse_cursor(targetingCursor)
	disabled = true
	disS = stance.disabled
	disI = item.disabled
	stance.disabled = true
	item.disabled = true
	targetMode = true
	var user = combatNode.activeUnit
	for i in range(user.cAction.targetOptions.size()):
		user.cAction.targetOptions[i].color = Color(0.6,0.1,0.1,1)


func TargetModeOff():
	Input.set_custom_mouse_cursor(get_node("/root/Globals").defaultCursor)
	targetMode = false
	stance.disabled = disS
	item.disabled = disI
	var user = combatNode.activeUnit
	for i in range(user.cAction.targetOptions.size()):
		user.cAction.targetOptions[i].color = Color(1,1,1,1)


func TargetSelected(action, target):
	TargetModeOff()
	var user = combatNode.activeUnit
	target = ProtectStanceCheck(action, target)
	
	action.Init(user, target)


func ActionFinished(action):
	var user = action.user
	
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


func ActionPressed(action):
	if(action.tags.targeted):
		ActionSelected(action)
	else:
		NTActionSelected(action)
	
	disabled = true
	_on_Action_toggled(false)


func _on_Action_toggled(button_pressed):
	pressed = button_pressed
	if(button_pressed):
		LoadActions()
		$List.show()
		stance._on_Stance_toggled(false)
		item._on_Item_toggled(false)
	else:
		$List.hide()