extends MenuButton

onready var combatNode = get_node("/root/Globals").combatScene


func _ready():
	get_popup().connect("id_pressed", self, "_on_Stance_id_pressed")
	get_popup().add_font_override("font",load("res://Fonts/CommandFont.tres"))


func _on_Stance_id_pressed(ID):
	var user = combatNode.activeUnit
	user.ChangeStance(user.stanceList[ID])
	user.ap -= user.stance.apCost
	combatNode.call_deferred("PassTurn")
	#combatNode.PassTurn()


func LoadStances():
	get_popup().clear()
	var activeUnit = combatNode.activeUnit
	
	for i in range(activeUnit.stanceList.size()):
		get_popup().add_item(activeUnit.stanceList[i].get_name(), i)
		
		if(!activeUnit.stanceList[i].UseCheck()):
			get_popup().set_item_disabled(i, true)