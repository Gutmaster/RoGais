extends PanelContainer


var unit

var black = Color(0, 0, 0)
var red = Color(200, 20, 20)
var green = Color(20, 200, 20)


func _ready():
	pass


func Init(u):
	unit = u
	SetValues()


func SetValues():
	find_node("Portrait").texture = unit.portrait
	find_node("Name").text = unit.get_name()
	
	find_node("HPFrac").text = str(unit.hp) + "/" + str(unit.aStats.Vitality)
	find_node("APFrac").text = str(unit.ap) + "/" + str(unit.aStats.Stamina)
	
	find_node("HPBar").value = float(unit.hp)/float(unit.aStats.Vitality) * 100
	find_node("APBar").value = float(unit.ap)/float(unit.aStats.Stamina) * 100
	
	var bonus
	var stat
	var aStat
	var bStat
	for i in range(7):
		if(i == 0):
			stat = find_node("Strength")
			aStat = unit.aStats.Strength
			bStat = unit.bStats.Strength
		elif(i == 1):
			stat = find_node("Endurance")
			aStat = unit.aStats.Endurance
			bStat = unit.bStats.Endurance
		elif(i == 2):
			stat = find_node("Wisdom")
			aStat = unit.aStats.Wisdom
			bStat = unit.bStats.Wisdom
		elif(i == 3):
			stat = find_node("Willpower")
			aStat = unit.aStats.Willpower
			bStat = unit.bStats.Willpower
		elif(i == 4):
			stat = find_node("Vitality")
			aStat = unit.aStats.Vitality
			bStat = unit.bStats.Vitality
		elif(i == 5):
			stat = find_node("Stamina")
			aStat = unit.aStats.Stamina
			bStat = unit.bStats.Stamina
		elif(i == 6):
			stat = find_node("Speed")
			aStat = unit.aStats.Speed
			bStat = unit.bStats.Speed
		
		stat.get_node("Base").text = str(bStat)
		bonus = aStat - bStat
		if(bonus == 0):
			stat.get_node("Bonus").visible = false
		elif(bonus > 0):
			stat.get_node("Bonus").text = "+" + str(aStat - bStat)
			stat.get_node("Bonus").add_color_override("font_color", green)
		elif(bonus < 0):
			stat.get_node("Bonus").text = "-" + str(aStat - bStat)
			stat.get_node("Bonus").add_color_override("font_color", red)