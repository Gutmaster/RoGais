extends TextureRect


var unit
onready var combatNode = get_node("/root/Globals").combatScene



func _ready():
	pass


func _process(delta):
	if(unit != null):
		if(combatNode.hoverUnit == unit):
			self_modulate = Color(1,1,0.4,1)
		else:
			self_modulate = Color(1,1,1,1)


func _on_QueueSlot_mouse_entered():
	combatNode.hoverUnit = unit


func _on_QueueSlot_mouse_exited():
	combatNode.hoverUnit = null