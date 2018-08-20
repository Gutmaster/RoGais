extends TextureButton


func _ready():
	pass


func _on_ShiftLeft_pressed():
	get_parent().combatNode.activeUnit.Shift(true)
	get_parent().combatNode.activeUnit.UpdateAP(-1)
	disabled = true
	get_parent().get_node("ShiftRight").disabled = true


func _on_ShiftRight_pressed():
	get_parent().combatNode.activeUnit.Shift(false)
	get_parent().combatNode.activeUnit.UpdateAP(-1)
	disabled = true
	get_parent().get_node("ShiftLeft").disabled = true