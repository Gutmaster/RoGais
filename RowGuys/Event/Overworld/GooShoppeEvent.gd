extends "res://Event/EventMenu.gd"

func _ready():
	pass


func _on_Enter_pressed():
	party.find_node("HUD").visible = false
	$Shop.find_node("ShopMenu").visible = true
	$Shop.ShopInit()


func _on_Leave_pressed():
	if(eventMenu.visible):
		close_event()