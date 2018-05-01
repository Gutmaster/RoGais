extends PanelContainer


var unit
var mouseHover
onready var combatNode = get_node("/root/Globals").combatScene


func _ready():
	set_process(true)


func _process(delta):
	find_node("HPFrac").set_text("HP " + str(unit.stats.hp) + "/" + str(unit.stats.Vitality))
	find_node("APFrac").set_text("AP " + str(unit.stats.ap) + "/" + str(unit.stats.Stamina))
	find_node("HPBar").set_value((float(unit.stats.hp)/unit.stats.Vitality) * 100)
	find_node("APBar").set_value((float(unit.stats.ap)/unit.stats.Stamina) * 100)


func _on_QuickStats_mouse_entered():
	combatNode.mouseHover = unit


func _on_QuickStats_mouse_exited():
	combatNode.mouseHover = null
