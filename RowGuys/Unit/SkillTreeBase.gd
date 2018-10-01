extends Sprite


var unit = null


func _ready():
	pass


func process():
	$SkillPoints.text = str(unit.skillPoints)


func _unhandled_input(event):
	if(event is InputEventKey && event.pressed):
		if(event.scancode == KEY_ESCAPE):
			Regress()
		if(event.scancode == KEY_UP):
			unit.LevelUp()


func _on_Regress_pressed():
	Regress()


func Regress():
	var values = $LevelCard.find_node("Values")
	for i in range(values.get_child_count()):
		values.get_child(i).tempPoints = 0
	
	unit.bStats.Endurance = $LevelCard.find_node("End").value
	unit.bStats.Speed = $LevelCard.find_node("Spd").value
	unit.bStats.Stamina = $LevelCard.find_node("Stm").value
	unit.bStats.Strenth = $LevelCard.find_node("Str").value
	unit.bStats.Vitality = $LevelCard.find_node("Vit").value
	unit.bStats.Willpower = $LevelCard.find_node("Wil").value
	unit.bStats.Wisdom = $LevelCard.find_node("Wis").value
	
	get_node("/root/Globals").ChangeScene(get_node("/root/Globals").prevSceneST)


func _on_Background_tree_entered():
	request_ready()


func HideUnusedDescript():
	var skillnodes = get_tree().get_nodes_in_group("skillnodes")
	for i in skillnodes:
		for j in range(i.maxLvl):
			if(i.action.descriptArray[j] == ""):
				i.action.descriptBox.get_node("Level" + str(j + 1)).hide()