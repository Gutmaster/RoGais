extends "res://Status/Status.gd"


func _ready():
	pwrLabel = get_node("Power")


func _process(delta):
	pwrLabel.text = str(power)


func Init():
	type = STATUS.poison


func Upkeep(unit):
	unit.UpdateHP(-power)
	power -= 1
	
	if(power <= 0):
		SelfRemove(unit)