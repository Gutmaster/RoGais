extends Node2D


var moveFlag = true

onready var eventActive = false
onready var globals = get_node("/root/Globals")


func _ready():
	globals.ReParentParty(self)
	Init()


func _unhandled_input(event):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_RIGHT:
		var rooms = get_tree().get_nodes_in_group("Rooms")
		for i in rooms:
			i.get_node("Light").enabled = true


func Init():
	$Room1.connections.push_back($Room2)
	$Room1.connections.push_back($Room3)
	
	$Room2.connections.push_back($Room1)
	$Room2.connections.push_back($Room4)
	
	$Room3.connections.push_back($Room1)
	$Room3.connections.push_back($Room4)
	
	$Room4.connections.push_back($Room3)
	$Room4.connections.push_back($Room2)
	$Room4.connections.push_back($Room5)
	$Room4.connections.push_back($Room6)
	$Room4.connections.push_back($Room7)

	$Room5.connections.push_back($Room4)
	$Room6.connections.push_back($Room4)
	$Room7.connections.push_back($Room4)
	
	var rooms = get_tree().get_nodes_in_group("Rooms")
	for i in rooms:
		i.AddLines()
	
	$Room1/Light.enabled = true
	$Party.Move($Room1)