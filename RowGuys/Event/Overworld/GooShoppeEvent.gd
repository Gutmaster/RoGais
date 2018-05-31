extends "res://Event/EventMenu.gd"

func _ready():
	pass


func _on_ShopButton_pressed():
	party.find_node("HUD").visible = false
	$Shop.find_node("ShopMenu").visible = true
	if(!$Shop.init):
		$Shop.AddShopItem(party.itemCatalogue.get_node("Red Goo"))

	$Shop.ShopInit()


func _on_ExitButton_pressed():
	if(eventMenu.visible):
		print("exit")
		close_event()
		get_parent().wait()
