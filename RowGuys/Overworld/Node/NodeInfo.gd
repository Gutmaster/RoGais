extends PanelContainer


onready var globals = get_node("/root/Globals")
onready var party = globals.party


func _ready():
	pass


func Update(partyPos, nodePos):
	AdjustPosition()
	var distance = int(partyPos.distance_to(nodePos))/10
	var cycles = distance/10
	find_node("Distance").text = str(distance) + str(" km")
	
	var foodReq = 0
	for i in range(cycles):
		for i in range(party.get_node("Units").get_child_count()):
			var unit = party.get_node("Units").get_child(i)
			if(unit.eatFlag):
				foodReq += unit.eatRate
	
	find_node("FoodRequired").text = str(foodReq)


func AdjustPosition():
	if(get_global_rect().position.x > get_viewport_rect().size.x*.7):
		rect_position.x = -rect_size.x
	if(get_global_rect().position.y > get_viewport_rect().size.y*.7):
		rect_position.y = -rect_size.y