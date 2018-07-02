extends HBoxContainer

var unit = null
var value
var tempPoints = 0


func _ready():
	set_process(false)


func _process(delta):
	if(unit.attributePoints > 0):
		$Up.disabled = false
	else:
		$Up.disabled = true
	if(tempPoints <= 0):
		$Dwn.disabled = true
	else:
		$Dwn.disabled = false


func Init(val, unit_):
	unit = unit_
	value = val
	$Val.text = str(value)
	set_process(true)


func _on_Dwn_pressed():
	tempPoints -= 1
	unit.attributePoints += 1
	value -= 1
	$Val.text = str(value)


func _on_Up_pressed():
	value += 1
	unit.attributePoints -= 1
	tempPoints += 1
	$Dwn.disabled = false
	$Val.text = str(value)
	print(unit.bStats.Strength)