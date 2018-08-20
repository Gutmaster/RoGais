extends MenuButton

onready var combatNode = get_node("/root/Globals").combatScene

func _ready():
	get_popup().add_item ("Left")
	get_popup().add_item ("Right")
	get_popup().connect("id_pressed", self, "_on_Shift_id_pressed")
	get_popup().add_font_override("font",load("res://Fonts/CommandFont.tres"))


func _on_Shift_id_pressed(ID):
	if ID == 0:
		combatNode.activeUnit.Shift(true)
	elif ID == 1:
		combatNode.activeUnit.Shift(false)
	
	combatNode.activeUnit.UpdateAP(-1)
	disabled = true


func SetOoBShift():
	var user = combatNode.activeUnit
	
	if(user.rowRef.terrain.tags.trapping):
		get_popup().set_item_disabled(0, true)
		get_popup().set_item_disabled(1, true)
		return
		
	get_popup().set_item_disabled(0, false)
	get_popup().set_item_disabled(1, false)
		
	if(user.row == user.ROW.front):
		if(user.team == combatNode.get_node("TeamLeft")):
			get_popup().set_item_disabled(1, true)
			if(user.team.rpos.middle.terrain.tags.blocking):
				get_popup().set_item_disabled(0, true)
		else:
			get_popup().set_item_disabled(0, true)
			if(user.team.rpos.middle.terrain.tags.blocking):
				get_popup().set_item_disabled(1, true)
	elif(user.row == user.ROW.back):
		if(user.team == combatNode.get_node("TeamLeft")):
			get_popup().set_item_disabled(0, true)
			if(user.team.rpos.middle.terrain.tags.blocking):
				get_popup().set_item_disabled(1, true)
		else:
			get_popup().set_item_disabled(1, true)
			if(user.team.rpos.middle.terrain.tags.blocking):
				get_popup().set_item_disabled(0, true)
	elif(user.row == user.ROW.middle):
		if(user.team == combatNode.get_node("TeamLeft")):
			if(user.team.rpos.back.terrain.tags.blocking):
				get_popup().set_item_disabled(0, true)
			if(user.team.rpos.front.terrain.tags.blocking):
				get_popup().set_item_disabled(1, true)
		else:
			if(user.team.rpos.back.terrain.tags.blocking):
				get_popup().set_item_disabled(1, true)
			if(user.team.rpos.front.terrain.tags.blocking):
				get_popup().set_item_disabled(0, true)