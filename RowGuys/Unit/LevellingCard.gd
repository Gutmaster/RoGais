extends Container

var unit = null


func _ready():
	set_process(false)


func _process(delta):
	$AttPoints.text = str(unit.attributePoints)


func Init(unit_):
	unit = unit_
	find_node("Portrait").texture = unit.portrait
	find_node("Name").text = unit.get_name()
	
	find_node("End").Init(unit.bStats.Endurance, unit)
	find_node("Spd").Init(unit.bStats.Speed, unit)
	find_node("Stm").Init(unit.bStats.Stamina, unit)
	find_node("Str").Init(unit.bStats.Strength, unit)
	find_node("Vit").Init(unit.bStats.Vitality, unit)
	find_node("Wil").Init(unit.bStats.Willpower, unit)
	find_node("Wis").Init(unit.bStats.Wisdom, unit)
	
	set_process(true)