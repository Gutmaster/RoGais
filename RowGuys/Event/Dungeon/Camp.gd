extends "res://Event/Dungeon/BaseDungeonScene.gd"


onready var foodCost = party.get_child_count()*2
onready var Rest = get_node("Container/EventMenu/VBoxContainer/Rest")


func _ready():
	Rest.text = Rest.text + " (-" + str(foodCost) + " food)"
	if(foodCost > party.food):
		find_node("Rest").disabled = true


func close_event():
	get_node("/root/Dungeon").eventActive = false
	queue_free()


func _on_Rest_pressed():
	DisableButtons()
	var units = party.get_node("Units")
	party.UpdateFood(-units.get_child_count()*2)
	for i in units.get_child_count():
		units.get_child(i).UpdateHealth(units.get_child(i).stats.Vitality/2)
	$EventResult.replace_by_instance()
	$EventResult/Container/EventResult/Text.text = "The party establishes watch order and a few hours pass by in relative peace. You prepare to leave."


func _on_Leave_pressed():
	DisableButtons()
	$EventResult.replace_by_instance()
	$EventResult/Container/EventResult/Text.text = "There's no time for relaxation, you move out."