extends "res://InfoBox/InfoTemplate.gd"

var level = 1
var stats = {"Vitality" : 0, "Stamina" : 0, "Strength" : 0, 
"Wisdom" : 0, "Endurance" : 0, "Willpower" : 0, "Speed" : 0}


func _ready():
	pass


func SetInfo():
	descriptBox.get_node("Level1").set_text(descript[0])
	descriptBox.get_node("Level2").set_text(descript[1])
	descriptBox.get_node("Level3").set_text(descript[2])
	
	var attribute
	var textBox
	for i in range(7):
		if(i == 0):
			attribute = stats.Strength
			textBox = infoBox.find_node("Strength")
		elif(i == 1):
			attribute = stats.Endurance
			textBox = infoBox.find_node("Endurance")
		elif(i == 2):
			attribute = stats.Wisdom
			textBox = infoBox.find_node("Wisdom")
		elif(i == 3):
			attribute = stats.Willpower
			textBox = infoBox.find_node("Willpower")
		elif(i == 4):
			attribute = stats.Vitality
			textBox = infoBox.find_node("Vitality")
		elif(i == 5):
			attribute = stats.Stamina
			textBox = infoBox.find_node("Stamina")
		elif(i == 6):
			attribute = stats.Speed
			textBox = infoBox.find_node("Speed")
		
		if(attribute > 0):
			textBox.get_node("Amount").text = "+" + str(attribute)
			textBox.visible = true
		elif(attribute < 0):
			textBox.get_node("Amount").text = "-" + str(attribute)
			textBox.visible = true


func _process(delta):
	pass


func Init():
	pass


func _on_Passive_mouse_entered():
	HoverInfo()


func _on_Passive_mouse_exited():
	NoHover()