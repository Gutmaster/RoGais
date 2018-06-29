extends CanvasLayer

onready var party = get_node("/root/Globals").party
onready var uList = party.get_node("Units")

onready var sellPrice = find_node("SellingPrice")

onready var firstInit = true
var hasShopItem = false

var returnDest
var bottomRow


func _ready():
	$ShopMenu.visible = false
	find_node("ArtifactDescription").text = " "
	sellPrice.text = " "


func _process(delta):
	if(party.itemHolder.item):
		sellPrice.text = "$" + str(party.itemHolder.item.sellPrice)
		print(party.itemHolder.item.get_name())
		print(party.itemHolder.item.description)
		find_node("Description").set_text(party.itemHolder.item.description)
	else:
		sellPrice.text = " "
		find_node("Description").set_text(" ")


func ShopInit():
	hasShopItem = false
	get_node("/root/Globals").shop = self
	
	if(firstInit):
		firstInit = false
		AddShopItem(party.itemCatalogue.PullRandom())
		AddShopItem(party.itemCatalogue.PullRandom())
		AddShopItem(party.itemCatalogue.PullRandom())
		AddShopItem(party.trinketCatalogue.PullRandom())
	
	find_node("FoodCount").text = str(party.food)
	find_node("GoldCount").text = str(party.gold)
	
	bottomRow = party.bottomRow
	returnDest = party.bottomRow.get_parent()
	bottomRow.get_parent().remove_child(bottomRow)
	find_node("Bottom").add_child(bottomRow)
	
	for i in range(uList.get_child_count()):
		var unit = uList.get_child(i)
		
		unit.partyCard.get_parent().remove_child(unit.partyCard)
		
		var panelString = "MiniPanel" + str(i+1)
		print(panelString)
		find_node(panelString).add_child(unit.partyCard)
	
	party.UpdatePartyCards()


func _on_ExitButton_pressed():
	if(!(party.itemHolder.item)):
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
	
		for i in range(uList.get_child_count()):
			var unit = uList.get_child(i)
		
			unit.partyCard.get_parent().remove_child(unit.partyCard)
		
			var panelString = "Panel" + str(i+1)
			print(panelString)
			party.find_node(panelString).add_child(unit.partyCard)
	
		Globals.shop = false


func AddShopItem(newItem):
	#var newItem = item.Clone()
	var found = false
	
	for i in range(1, 6):
		if(!found):
			var slotString = ""
			
			print(str(newItem.iType))
			
			if(newItem.iType == newItem.ITYPE.item):
				slotString = "ItemSlot" + str(i)
			elif(newItem.iType == newItem.ITYPE.trinket):
				slotString = "TrinketSlot" + str(i)
			elif(newItem.iType == newItem.ITYPE.artifact):
				slotString = "ArtifactSlot" + str(i)
			else:
				slotString = "ItemSlot" + str(i)
			
			var slot = find_node(slotString)
		
			if(slot.item == null):
				found = true
				slot.item = newItem
				slot.add_child(newItem)
				print(slot.get_name(), slot.get_child_count())


func _on_SellButton_pressed():
	if(party.itemHolder.item && !(Globals.shop.hasShopItem)):
		party.UpdateGold(party.itemHolder.item.sellPrice)
		party.itemHolder.remove_child(party.itemHolder.item)
		AddShopItem(party.itemHolder.item.duplicate())
		party.itemHolder.item = null


func _on_BuyFood_pressed():
	if(!(party.itemHolder.item)):
		var price = 7
	
		if(party.gold >= 7):
			party.UpdateGold(-price)
			party.UpdateFood(1)
			find_node("FoodCount").text = str(party.food)
			find_node("GoldCount").text = str(party.gold)


func _on_SellFood_pressed():
	if(!(party.itemHolder.item)):
		var price = 4
	
		if(party.food >= 1):
			party.UpdateGold(price)
			party.UpdateFood(-1)
			find_node("FoodCount").text = str(party.food)
			find_node("GoldCount").text = str(party.gold)

