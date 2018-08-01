extends TextureRect


var moveFlag = true

onready var eventActive = false
onready var globals = get_node("/root/Globals")


func _ready():
	#globals.ReParentParty(self)
	Init()


func _unhandled_input(event):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_RIGHT:
		var hex = get_tree().get_nodes_in_group("Hex")
		for i in hex:
			i.get_node("Light").enabled = true


func Init():
	$Hex1.connections.push_back($Hex2)
	$Hex1.connections.push_back($Hex3)
	
	$Hex2.connections.push_back($Hex1)
	$Hex2.connections.push_back($Hex4)
	
	$Hex3.connections.push_back($Hex1)
	$Hex3.connections.push_back($Hex5)
	
	$Hex4.connections.push_back($Hex6)
	$Hex4.connections.push_back($Hex2)

	$Hex5.connections.push_back($Hex3)
	$Hex5.connections.push_back($Hex6)
	$Hex5.connections.push_back($Hex7)
	
	$Hex6.connections.push_back($Hex4)
	$Hex6.connections.push_back($Hex5)
	$Hex6.connections.push_back($Hex7)
	
	$Hex7.connections.push_back($Hex5)
	$Hex7.connections.push_back($Hex6)
	$Hex7.connections.push_back($Hex8)
	
	$Hex8.connections.push_back($Hex7)
	
	#var hex = get_tree().get_nodes_in_group("Hex")
	#for i in hex:
	#	i.AddLines()
	
	$Hex1/Light.enabled = true
	$Party.Move($Hex1)