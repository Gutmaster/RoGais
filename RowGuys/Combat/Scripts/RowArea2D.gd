extends Area2D

onready var combatNode = get_node("/root/Globals").combatScene

func _ready():
	pass


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT:
		combatNode.get_node("HUD/CommandWindow/Action").TargetCheck(get_parent())


func _on_Area2D_mouse_entered():
	get_parent().mouseHover = true


func _on_Area2D_mouse_exited():
	get_parent().mouseHover = false