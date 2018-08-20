extends Sprite


var events = []
var Event
var mouseHover = false
var visited = false

onready var partyIcon = get_parent().get_node("PartyIcon")


func _ready():
	#events.push_back(load("res://Event/Dungeon/Swamp/GoldChasm.tscn"))
	events.push_back(load("res://Event/Dungeon/Swamp/Ambush.tscn"))
	#events.push_back(load("res://Event/Dungeon/Camp.tscn"))


func _process(delta):
	HoverMod()


func MoveParty():
	if(!visited):
		randomize()
		$Event.replace_by_instance(events[randi()%events.size()])
		$Event/Container.visible = true
		get_parent().eventActive = true
	
	visited = true
	
	partyIcon.currentNode = self


func HoverMod():
	if(mouseHover):
		self_modulate = Color(1,1,0.4,1)
	else:
		self_modulate = Color(1,1,1,1)