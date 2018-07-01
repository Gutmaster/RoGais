extends PanelContainer


var queue = []

onready var combatNode = get_node("/root/Combat")
onready var uList = get_node("/root/Globals").combatScene.get_node("UnitList")
#onready var queue = find_node("Inactive")
#onready var active = find_node("Active/0")


func _ready():
	queue.push_back(get_node("Slots/0"))
	queue.push_back(get_node("Slots/1"))
	queue.push_back(get_node("Slots/2"))
	queue.push_back(get_node("Slots/3"))
	queue.push_back(get_node("Slots/4"))
	queue.push_back(get_node("Slots/5"))
	queue.push_back(get_node("Slots/6"))
	queue.push_back(get_node("Slots/7"))
	queue.push_back(get_node("Slots/8"))
	queue.push_back(get_node("Slots/9"))


func Init():
	for i in range(10):
		var slot = load("res://Combat/Queue/QueueSlot.tscn").instance()
		slot.unit = GetNext()
		slot.set_texture(slot.unit.portrait)
		queue[i].add_child(slot)


func InsertNext(pos):
	var nextUnit = GetNext()
	
	var slot = load("res://Combat/Queue/QueueSlot.tscn").instance()
	slot.unit = nextUnit
	slot.set_texture(nextUnit.portrait)
	
	queue[pos].add_child(slot)
	slot.Appear()


func Update():
	queue[0].remove_child(queue[0].get_child(0))
	
	for i in range(1, queue.size()):
		queue[i].get_child(0).Migrate(queue[i-1])
	
	InsertNext(9)
	combatNode.activeUnit = queue[0].get_child(0).unit


func GetNext():
	var nextUnit = combatNode.activeUnit
	for i in range(uList.get_child_count()):
		var temp = uList.get_child(i)
		temp.initiative += temp.aStats.Speed
		if(temp.initiative > nextUnit.initiative):
			nextUnit = temp
	
	nextUnit.initiative = 0
	return nextUnit


func PushBack(target, power):
	var slot
	for i in range(9):
		if(target == queue[i].get_child(0).unit):
			slot = queue[i]
			while(i + power > 9):
				power -= 1
			if(power > 0):
				slot.get_child(0).Migrate(queue[i+power])
				for j in range(1, power+1):
					queue[i+j].get_child(0).Migrate(queue[i+j-1])
			return


func RemoveUnit(unit):
	var slots = 0
	for i in range(queue.size()):
		if(queue[i].get_child(0).unit == unit):
			queue[i].remove_child(queue[i].get_child(0))
			slots += 1
	
	var count = 0
	var i = 0
	while(i < queue.size()):
		if(!queue[i].get_child_count()):
			count += 1
		elif(count):
			queue[i].get_child(0).Migrate(queue[i - count])
			i -= count
			count = 0
		i += 1
	
	for i in range(slots):
		InsertNext(9 - i)


func Clear():
	for i in range(queue.size()):
		queue[i].remove_child(queue[i].get_child(0))

"""func QueuePredict():
	for i in range(uList.get_child_count()):
		uList.get_child(i).qInitiative = uList.get_child(i).initiative
		
	for i in range(1, 10):
		var nextUnit = combatNode.activeUnit
		for j in range(uList.get_child_count()):
			var temp = uList.get_child(j)
			temp.qInitiative += temp.aStats.Speed
			if(temp.qInitiative > nextUnit.qInitiative):
				nextUnit = temp
		
		queue[i].unit = nextUnit
		nextUnit.qInitiative = 0
	
	for i in range(queue.size()):
		queue[i].set_texture(queue[i].unit.portrait)"""