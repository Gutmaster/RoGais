extends "res://Status/Status.gd"


func _ready():
	pwrLabel = get_node("Label")


func _process(delta):
	pwrLabel.text = str(power)


func Init():
	type = STATUS.poison


func Upkeep(unit):
	unit.UpdateHP(-power)
	power -= 1
	
	#unit.quickStats.find_node("StatusPower").text = str(power)
	
	if(unit.is_in_group("Party")):
		pass#unit.partyCard.find_node("StatusPower").text = str(power)
	
	if(power <= 0):
		SelfRemove(unit)
		#unit.quickStats.find_node("StatusPower").text = ""
		
		if(unit.is_in_group("Party")):
			pass#unit.partyCard.find_node("StatusPower").text = ""