extends Sprite


var connections = []
var events = []
var Event
var mouseHover = false
var adjacent = false
var visited = false

onready var party = get_parent().get_node("Party")


func _ready():
	events.push_back(load("res://Event/Dungeon/Swamp/GoldChasm.tscn"))
	events.push_back(load("res://Event/Dungeon/Swamp/Ambush.tscn"))
	events.push_back(load("res://Event/Dungeon/Camp.tscn"))


func AddLines():
	for i in range(connections.size()):
		var line = Line2D.new()
		line.add_point(position)
		line.add_point(connections[i].position)
		line.visible = true
		get_parent().add_child(line)
		get_parent().move_child(line, 1)


func _process(delta):
	HoverMod()


func MoveParty():
	if(!visited):
		randomize()
		$Event.replace_by_instance(events[randi()%events.size()])
		$Event/CenterContainer.visible = true
		get_parent().eventActive = true
	
	visited = true
	
	if(party.currentRoom != null):
		for i in range(party.currentRoom.connections.size()):
			party.currentRoom.connections[i].adjacent = false
			
	party.currentRoom = self
	
	for i in range(connections.size()):
		connections[i].adjacent = true
		connections[i].get_node("Light").enabled = true


func HoverMod():
	if(mouseHover):
		self_modulate = Color(1,1,0.4,1)
	else:
		self_modulate = Color(1,1,1,1)