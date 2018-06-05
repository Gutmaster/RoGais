extends CanvasLayer


onready var party = get_node("/root/Globals").party

onready var itemHolder = $ShopItemHolder
onready var init = false

var returnDest
var bottomRow

func _ready():
	$ShopMenu.visible = false
	find_node("ArtifactDescription").text = " "


func ShopInit():
	init = true
	
	find_node("FoodCount").text = str(party.food)
	find_node("GoldCount").text = str(party.gold)
	
	var artifact
	
	bottomRow = party.bottomRow
	returnDest = party.bottomRow.get_parent()
	bottomRow.get_parent().remove_child(bottomRow)
	find_node("Bottom").add_child(bottomRow)
	
	
	Globals.shop = self
	
	
	"""if(party.artifactSlot.item):
		artifact = party.artifactSlot.item.duplicate()
	
		find_node("ArtifactSlot").add_child(artifact)
		find_node("ArtifactSlot").item = artifact
	
		find_node("ArtifactSlot").shop = self
	
		find_node("ArtifactDescription").text = artifact.description
	
	for i in range(1,9):
		var slotString = "Slot" + str(i)
		var slot = find_node(slotString)
		
		if(slot.item != null):
			slot.remove_child(slot.get_child(1))
			slot.item = null
			
		var partySlot = party.find_node(slotString)
		
		if(partySlot.item):
			slot.item = partySlot.item.duplicate()
			slot.add_child(slot.item)
			
			slot.shop = self"""
			
			
	

			
	for i in range(1,6):
		find_node("ItemSlot" + str(i)).shop = self
		find_node("TrinketSlot" + str(i)).shop = self
		find_node("ArtifactSlot" + str(i)).shop = self
	
	UpdateShopPartyCards()

func UpdateShopPartyCards():
	var uList
	var count

	uList = party.find_node("Units")

	for j in range(1,6):
		var panelString = "MiniPanel" + str(j)
		if(find_node(panelString).get_child_count()):
			call_deferred("find_node(panelString).remove_child", find_node(panelString).get_child(0))
	
	for i in range(uList.get_child_count()):
		var unit
		
		unit = uList.get_child(i)
		
		unit.RefreshStats()
		
		var panelString = "MiniPanel" + str(i+1)
		print(panelString)
	
		unit.partyCard.find_node("HPFrac").set_text("HP " + str(unit.hp) + "/" + str(unit.aStats.Vitality))
		unit.partyCard.find_node("APFrac").set_text("AP " + str(unit.ap) + "/" + str(unit.aStats.Stamina))
		unit.partyCard.find_node("XPFrac").set_text("XP " + str(unit.xp) + "/" + str(unit.xpReq))
		unit.partyCard.find_node("HPBar").set_value((float(unit.hp)/unit.aStats.Vitality) * 100)
		unit.partyCard.find_node("APBar").set_value((float(unit.ap)/unit.aStats.Stamina) * 100)
	
		unit.partyCard.find_node("VitStat").set_text(" VIT " + str(unit.aStats.Vitality))
		unit.partyCard.find_node("StaStat").set_text(" STA " + str(unit.aStats.Stamina))
		unit.partyCard.find_node("StrStat").set_text(" STR " + str(unit.aStats.Strength))
		unit.partyCard.find_node("EndStat").set_text(" END " + str(unit.aStats.Endurance))
	
		unit.partyCard.find_node("WisStat").set_text(" WIS " + str(unit.aStats.Wisdom))
		unit.partyCard.find_node("WillStat").set_text("WILL " + str(unit.aStats.Willpower))
		unit.partyCard.find_node("SpeedStat").set_text(" SPD " + str(unit.aStats.Speed))
		
		"""var trinketSlot1 = unit.partyCard.find_node("TrinketSlot")
		var trinketSlot2 = unit.partyCard.find_node("TrinketSlot2")
		
		if(unit.trinket1 != null):
			var trinket = unit.trinket1.duplicate()
			trinketSlot1.add_child(trinket)
			trinketSlot1.item = trinket
		elif(unit.trinket2 != null):
			var trinket = unit.trinket2.duplicate()
			trinketSlot2.add_child(trinket)
			trinketSlot2.item = trinket"""
		
		find_node(panelString).add_child(unit.partyCard.duplicate())


func _on_ExitButton_pressed():
	if(itemHolder.item):
		itemHolder.itemCatcher.item = itemHolder.item
		itemHolder.remove_child(itemHolder.itemCatcher.item)
		itemHolder.item = null
		itemHolder.itemCatcher.add_child(itemHolder.itemCatcher.item)
		
		if(itemHolder.itemCatcher.item.iType == party.ITYPE.artifact):
			itemHolder.itemCatcher.item.Acquire()
			$ArtifactContainer.add_child(itemHolder.itemCatcher.item.duplicate())
	
	$ShopMenu.visible = false
	party.find_node("HUD").visible = true
	
	var artifactSlot = find_node("ArtifactSlot")
	
	if(artifactSlot.item):
		artifactSlot.remove_child(artifactSlot.get_child(1))
		
	find_node("ArtifactDescription").text = " "
	
	bottomRow.get_parent().remove_child(bottomRow)
	returnDest.add_child(bottomRow)
	bottomRow = null
	returnDest = null
	
	Globals.shop = false


func AddShopItem(item):
	item = item.duplicate()
	var found = false
	
	for i in range(1, 6):
		if(!found):
			var slotString = "ItemSlot" + str(i)
			var slot = find_node(slotString)
		
			if(slot.item == null):
				found = true
				slot.item = item
				slot.add_child(item)
				print(slot.get_name(), slot.get_child_count())


func _on_SellButton_pressed():
	pass # replace with function body


func _on_BuyFood_pressed():
	var price = 7
	
	if(party.gold >= 7):
		party.UpdateGold(-price)
		party.UpdateFood(1)
		find_node("FoodCount").text = str(party.food)
		find_node("GoldCount").text = str(party.gold)
		


func _on_SellFood_pressed():
	var price = 4
	
	if(party.food >= 1):
		party.UpdateGold(price)
		party.UpdateFood(-1)
		find_node("FoodCount").text = str(party.food)
		find_node("GoldCount").text = str(party.gold)

