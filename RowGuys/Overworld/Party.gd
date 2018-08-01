extends Sprite

var currentNode = null
var nextNode = null
var travelTime
var timeTraveled
var cycle
var totalCycles
onready var party = get_node("/root/Globals").party


func _ready():
	set_process(false)
	currentNode = get_parent().find_node("Node1")


func _process(delta):
	timeTraveled += delta
	if(timeTraveled > travelTime/totalCycles * cycle):
		get_parent().Eat()
		cycle += 1
		if(cycle > totalCycles):
			set_process(false)


func Move(node):
	nextNode = node
	var distance = position.distance_to(node.position)
	travelTime = distance/200
	
	$Tween.interpolate_property(self, "position", position, node.position, travelTime, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	
	totalCycles = distance/100
	cycle = 1
	timeTraveled = 0
	set_process(true)
	get_parent().moveFlag = true


func _on_Tween_tween_completed(object, key):
	get_parent().moveFlag = false
	nextNode.MoveParty()