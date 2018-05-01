extends PanelContainer


var queue = []

onready var combatNode = get_node("/root/Combat")
onready var uList = get_node("/root/Globals").combatScene.get_node("UnitList")


func _ready():
	queue.push_back($ActiveSplit/ActiveUnit)
	queue.push_back($ActiveSplit/Crud/Inactive/Next1)
	queue.push_back($ActiveSplit/Crud/Inactive/Next2)
	queue.push_back($ActiveSplit/Crud/Inactive/Next3)
	queue.push_back($ActiveSplit/Crud/Inactive/Next4)
	queue.push_back($ActiveSplit/Crud/Inactive/Next5)
	queue.push_back($ActiveSplit/Crud/Inactive/Next6)
	queue.push_back($ActiveSplit/Crud/Inactive/Next7)
	queue.push_back($ActiveSplit/Crud/Inactive/Next8)
	queue.push_back($ActiveSplit/Crud/Inactive/Next9)


func QueueUpdate():
	var nextUnit = combatNode.activeUnit
	for i in range(uList.get_child_count()):
		var temp = uList.get_child(i)
		temp.initiative += temp.stats.Speed
		if(temp.initiative > nextUnit.initiative):
			nextUnit = temp
			
	combatNode.activeUnit = nextUnit
	combatNode.activeUnit.initiative = 0
	
	QueuePredict()


func QueuePredict():
	for i in range(uList.get_child_count()):
		uList.get_child(i).qInitiative = uList.get_child(i).initiative
		
	queue[0].unit = combatNode.activeUnit
	for i in range(1, 10):
		var nextUnit = combatNode.activeUnit
		for j in range(uList.get_child_count()):
			var temp = uList.get_child(j)
			temp.qInitiative += temp.stats.Speed
			if(temp.qInitiative > nextUnit.qInitiative):
				nextUnit = temp
				
		queue[i].unit = nextUnit
		nextUnit.qInitiative = 0
	
	for i in range(queue.size()):
		queue[i].set_texture(queue[i].unit.portrait)