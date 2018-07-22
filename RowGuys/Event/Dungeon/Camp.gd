extends "res://Event/Dungeon/BaseDungeonScene.gd"


onready var foodCost = party.get_child_count()*2
onready var rest = get_node("Container/EventMenu/ChoiceList/Rest")


func _ready():
	rest.text = rest.text + " (-" + str(foodCost) + " food)"
	if(foodCost > party.food):
		find_node("Rest").disabled = true


func close_event():
	get_node("/root/Dungeon").eventActive = false
	queue_free()


func _on_Rest_pressed():
	var units = party.get_node("Units")
	party.UpdateFood(-units.get_child_count()*2)
	for i in units.get_child_count():
		units.get_child(i).UpdateHealth(units.get_child(i).bStats.Vitality/2)
	
	ClearChoiceList()
	ReParent($ButtonBank, choices, $ButtonBank/Proceed)
	text.text = $TextBank/Rest.text


func _on_Leave_pressed():
	ClearChoiceList()
	ReParent($ButtonBank, choices, $ButtonBank/Proceed)
	text.text = $TextBank/Leave.text