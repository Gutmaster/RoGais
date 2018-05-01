extends TextureRect

onready var party = get_node("/root/Globals").party


var partyMod = {"Vitality" : 0, "Stamina" : 0, "Strength" : 0, "Wisdom" : 0, "Endurance" : 0, "Willpower" : 0, "Speed" : 0}
var enemyMod = {"Vitality" : 0, "Stamina" : 0, "Strength" : 0, "Wisdom" : 0, "Endurance" : 0, "Willpower" : 0, "Speed" : 0}


func _ready():
	pass


func Acquire():
	for i in range(party.find_node("Units").get_child_count()):
		party.find_node("Units").get_child(i).stats.Vitality += partyMod.Vitality
		party.find_node("Units").get_child(i).stats.Stamina += partyMod.Stamina
		party.find_node("Units").get_child(i).stats.Strength += partyMod.Strength
		party.find_node("Units").get_child(i).stats.Wisdom += partyMod.Wisdom
		party.find_node("Units").get_child(i).stats.Endurance += partyMod.Endurance
		party.find_node("Units").get_child(i).stats.Willpower += partyMod.Willpower
		party.find_node("Units").get_child(i).stats.Speed += partyMod.Speed


func Remove():
	for i in range(party.find_node("Units").get_child_count()):
		party.find_node("Units").get_child(i).stats.Vitality -= partyMod.Vitality
		party.find_node("Units").get_child(i).stats.Stamina -= partyMod.Stamina
		party.find_node("Units").get_child(i).stats.Strength -= partyMod.Strength
		party.find_node("Units").get_child(i).stats.Wisdom -= partyMod.Wisdom
		party.find_node("Units").get_child(i).stats.Endurance -= partyMod.Endurance
		party.find_node("Units").get_child(i).stats.Willpower -= partyMod.Willpower
		party.find_node("Units").get_child(i).stats.Speed -= partyMod.Speed


func EnemyMod(unit):
		unit.stats.Vitality += enemyMod.Vitality
		unit.stats.Stamina += enemyMod.Stamina
		unit.stats.Strength += enemyMod.Strength
		unit.stats.Wisdom += enemyMod.Wisdom
		unit.stats.Endurance += enemyMod.Endurance
		unit.stats.Willpower += enemyMod.Willpower
		unit.stats.Speed += enemyMod.Speed


func Upkeep():
	pass