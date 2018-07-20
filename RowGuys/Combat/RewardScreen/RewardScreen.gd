extends Container

onready var party = get_node("/root/Globals").party
onready var combatNode = get_node("/root/Globals").combatScene
onready var uList = combatNode.get_node("UnitList")

var bottomRow
var returnDest

var xpLabel
var goldLabel



func _ready():
	pass


func _process(delta):
	if(visible):
		find_node("XPCount").text = str(round(xpLabel))
		find_node("GoldCount").text = str(round(goldLabel))


func Init(xp, gold, itemVal):
	show()
	
	party.EnableSlots()
	
	bottomRow = party.bottomRow
	returnDest = party.bottomRow.get_parent()
	bottomRow.get_parent().remove_child(bottomRow)
	find_node("PartyItems").add_child(bottomRow)
	
	for i in range(uList.get_child_count()):
		var unit = uList.get_child(i)
		if(unit.partyCard == null):
			continue
		unit.partyCard.get_parent().remove_child(unit.partyCard)
		$UnitSlots.add_child(unit.partyCard)
		unit.UpdateXP(xp)
	
	party.UpdatePartyCards()
	party.UpdateGold(gold)
	
	xpLabel = xp
	goldLabel = gold
	
	find_node("XPCount").text = str(xp)
	find_node("GoldCount").text = str(gold)
	
	find_node("XPTween").interpolate_property(self, "xpLabel", xpLabel, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	find_node("XPTween").start()
	
	find_node("GoldTween").interpolate_property(self, "goldLabel", goldLabel, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	find_node("GoldTween").start()
	
	
	while(itemVal > 0):
		var newSlot = load("res://Party/Slot.tscn").instance()
		var newItem = party.itemCatalogue.PullRandom()
		newSlot.add_child(newItem)
		newSlot.item = newItem
		#print(newItem.item.buyPrice)
		itemVal -= newItem.buyPrice
		find_node("ItemBox").add_child(newSlot)


func Exit():
	hide()
	bottomRow.get_parent().remove_child(bottomRow)
	returnDest.add_child(bottomRow)
	bottomRow = null
	returnDest = null
	
	while(find_node("ItemBox").get_child_count()):
		find_node("ItemBox").remove_child(find_node("ItemBox").get_child(0))
	
	for i in range(uList.get_child_count()):
		var unit = uList.get_child(i)
		
		if(unit.partyCard != null):
			unit.partyCard.get_parent().remove_child(unit.partyCard)
			
			var panelString = "Panel" + str(i+1)
			print(panelString)
			party.find_node(panelString).add_child(unit.partyCard)


func _on_Victory_pressed():
	Exit()
	get_node("/root/Combat").EndBattle()