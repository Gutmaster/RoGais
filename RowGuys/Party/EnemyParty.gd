extends CanvasLayer


func _ready():
	pass


func AddUnit(var unit):
	unit = unit.instance()
	$Units.add_child(unit, true)
	unit.CharCardInit()
	$"HUD/Unit Cards".add_child(unit.quickStats)