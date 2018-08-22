extends Node2D


var moveFlag = true

onready var eventActive = false
onready var globals = get_node("/root/Globals")
onready var party = globals.party

onready var packedSmellNode = load("res://Overworld/Node/Swamp/SmellNode.tscn")
onready var packedNoiseNode = load("res://Overworld/Node/Swamp/NoiseNode.tscn")
onready var packedMonumentNode = load("res://Overworld/Node/Swamp/MonumentNode.tscn")

onready var nodeTypes = []
var nodeArray = []


func _ready():
	nodeTypes.push_back(packedNoiseNode)
	nodeTypes.push_back(packedSmellNode)
	nodeTypes.push_back(packedMonumentNode)
	add_child(get_node("/root/Globals").party)
	Init()


func Init():
	randomize()
	var nodeCount = randi()%10 + 5
	
	for i in range(nodeCount):
		var a = randi()%3
		print(a)
		var newNode = nodeTypes[a].instance()
		add_child(newNode)
		print(newNode.find_node("Type").text)
		var loopo = true
		while(loopo):
			loopo = false
			newNode.position = Vector2(randi()%int(get_viewport_rect().size.x), randi()%int(get_viewport_rect().size.y - 100))
			for j in range(nodeArray.size()):
				if(nodeArray[j].position.distance_to(newNode.position) < 50):
					print(newNode.position)
					loopo = true
		nodeArray.push_back(newNode)
		newNode.get_node("NodeInfo").AdjustPosition()
	
	$PartyIcon.Move($Start, true)
	$PartyIcon.raise()


func Eat():
	for i in range(party.get_node("Units").get_child_count()):
		var unit = party.get_node("Units").get_child(i)
		if(party.food <= 0 || !unit.eatFlag):
			unit.Starve()
		else:
			unit.Eat()
			party.UpdateFood(-unit.eatRate)