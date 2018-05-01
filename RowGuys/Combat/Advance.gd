extends TextureButton


onready var combatNode =  get_node("/root/Globals").combatScene


func _ready():
	pass


func Check():
	if(!combatNode.get_node("Row/RF").FindOccupants().size() &&
	  !combatNode.get_node("Row/LB").terrain.tags.trapping):
		Activate()
	else:
		Deactivate()


func Activate():
	visible = true
	disabled = false


func Deactivate():
	visible = false
	disabled = true


func _on_Advance_pressed():
	combatNode.Advance(combatNode.get_node("TeamRight"))