extends Container


var unit


func _ready():
	set_process(false)


func SwitchUnit(newUnit):
	unit = newUnit
	get_parent().get_node("CommandWindow").Init()
	if(unit.AI):
		get_parent().get_node("CommandWindow").hide()
	else:
		get_parent().get_node("CommandWindow").show()
	$Name.text = unit.idName
	set_process(true)


func _process(delta):
	if(unit.idName == null):
		return
	
	find_node("HPFrac").set_text("HP " + str(unit.hp) + "/" + str(unit.aStats.Vitality))
	find_node("APFrac").set_text("AP " + str(unit.ap) + "/" + str(unit.aStats.Stamina))
	find_node("HPBar").set_value((float(unit.hp)/unit.aStats.Vitality) * 100)
	find_node("APBar").set_value((float(unit.ap)/unit.aStats.Stamina) * 100)