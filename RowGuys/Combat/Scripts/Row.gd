extends Sprite

enum ROW{
front,
middle,
back}

var width
var height

var row = null

var left = false
var mouseHover = false
var color = Color(1,1,1,1)

onready var combatNode = get_node("/root/Globals").combatScene

onready var uList = combatNode.get_node("UnitList")
onready var terrain = combatNode.get_node("TerrainCatalogue/Default").duplicate()


func _ready():
	width = texture.get_width()
	height = texture.get_height()
	if(get_name() == "LB" || get_name() == "LM" || get_name() == "LF"):
		left = true
	if(get_name() == "LB" || get_name() == "RB"):
		row = ROW.back
	if(get_name() == "LM" || get_name() == "RM"):
		row = ROW.middle
	if(get_name() == "LF" || get_name() == "RF"):
		row = ROW.front
	add_child(terrain)


func _process(delta):
	HoverMod()


func SetTerrain(var ter):
	remove_child(terrain)
	#terrain.free()
	
	terrain = ter
	add_child(terrain)
	ter.Init(left)


func SwapTerrain(var ter):
	terrain = ter
	add_child(terrain)


func ClearTerrain():
	SetTerrain(combatNode.get_node("TerrainCatalogue/Default").duplicate())


#func Decay():
#	terrain.hp -= 1
#	if(terrain.hp <= 0):
#		ClearTerrain()


func HoverMod():
	var uCheck = true
	for i in range(uList.get_child_count()):
		if(uList.get_child(i).rowRef == self and \
		   uList.get_child(i).mouseHover):
			uCheck = false
			
	if(mouseHover && uCheck):
		self_modulate = Color(1,1,0.4,1)
	else:
		self_modulate = color


func SetLine(team):
	var line = get_node("UnitLine")
	for i in range(line.get_point_count()):
		line.remove_point(0)
	var count = team.teamIndex
	
	for i in range(count):
		line.add_point($UnitLine/Start.position + (i+1)*(($UnitLine/End.position-$UnitLine/Start.position)/(count+1)))


func FindOccupants():
	var occupants = []
	for i in range(uList.get_child_count()):
		if(uList.get_child(i).rowRef == self):
			occupants.push_back(uList.get_child(i))
	
	return occupants