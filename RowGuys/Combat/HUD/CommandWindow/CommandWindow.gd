extends Container

onready var combatNode = get_node("/root/Combat")
var unit

func _ready():
	pass


func Init():
	unit = combatNode.activeUnit
	SetOoBShift()
	$Advance.Check()
	if(unit.ap <= 0):
		$ShiftLeft.disabled = true
		$ShiftRight.disabled = true


func SetOoBShift():
	if(unit.rowRef.terrain.tags.trapping):
		$ShiftLeft.disabled = true
		$ShiftRight.disabled = true
		return
		
	$ShiftLeft.disabled = false
	$ShiftRight.disabled = false
		
	if(unit.row == unit.ROW.front):
		if(unit.team == combatNode.get_node("TeamLeft")):
			$ShiftRight.disabled = true
			if(unit.team.rpos.middle.terrain.tags.blocking):
				$ShiftLeft.disabled = true
		else:
			$ShiftLeft.disabled = true
			if(unit.team.rpos.middle.terrain.tags.blocking):
				$ShiftRight.disabled = true
	elif(unit.row == unit.ROW.back):
		if(unit.team == combatNode.get_node("TeamLeft")):
			$ShiftLeft.disabled = true
			if(unit.team.rpos.middle.terrain.tags.blocking):
				$ShiftRight.disabled = true
		else:
			$ShiftRight.disabled = true
			if(unit.team.rpos.middle.terrain.tags.blocking):
				$ShiftLeft.disabled = true
	elif(unit.row == unit.ROW.middle):
		if(unit.team == combatNode.get_node("TeamLeft")):
			if(unit.team.rpos.back.terrain.tags.blocking):
				$ShiftLeft.disabled = true
			if(unit.team.rpos.front.terrain.tags.blocking):
				$ShiftRight.disabled = true
		else:
			if(unit.team.rpos.back.terrain.tags.blocking):
				$ShiftRight.disabled = true
			if(unit.team.rpos.front.terrain.tags.blocking):
				$ShiftLeft.disabled = true


func _unhandled_input(event):
	if visible and event is InputEventKey \
	and event.pressed and event.scancode == KEY_L:
		combatNode.Advance(combatNode.get_node("TeamRight"))
	if visible and event is InputEventKey \
	and event.pressed and event.scancode == KEY_R:
		combatNode.Advance(combatNode.get_node("TeamLeft"))
	if visible and event is InputEventKey \
	and event.pressed and event.scancode == KEY_DELETE:
		var loopo = true
		while loopo:
			loopo = false
			for i in range(combatNode.uList.get_child_count()):
				if(combatNode.uList.get_child(i).teamLeft == false):
					combatNode.uList.get_child(i).UpdateHP(-100)
					loopo = true
					break
	if event is InputEventKey \
	and event.pressed and event.scancode == KEY_P:
		print_tree()