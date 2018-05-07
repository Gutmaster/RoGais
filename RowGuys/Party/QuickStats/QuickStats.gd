extends PanelContainer


var unit
var mouseHover
onready var combatNode = get_node("/root/Globals").combatScene


func _ready():
	set_process(true)


func _process(delta):
	if(unit.idName == null):
		return
	
	find_node("HPFrac").set_text("HP " + str(unit.hp) + "/" + str(unit.aStats.Vitality))
	find_node("APFrac").set_text("AP " + str(unit.ap) + "/" + str(unit.aStats.Stamina))
	find_node("HPBar").set_value((float(unit.hp)/unit.aStats.Vitality) * 100)
	find_node("APBar").set_value((float(unit.ap)/unit.aStats.Stamina) * 100)


func _on_QuickStats_mouse_entered():
	combatNode.mouseHover = unit


func _on_QuickStats_mouse_exited():
	combatNode.mouseHover = null
