extends Sprite


var events = []
var Event
var mouseHover = false
var visited = false

onready var partyIcon = get_parent().get_node("PartyIcon")


func _ready():
	$NodeInfo.find_node("Type").text = "Node"


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
		if(partyIcon.currentNode != self):
			$NodeInfo.Update(partyIcon.position, position)
			$NodeInfo.show()
	else:
		self_modulate = Color(1,1,1,1)
		$NodeInfo.hide()