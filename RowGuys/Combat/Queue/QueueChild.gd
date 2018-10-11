extends TextureRect

var mouseHover = false

var unit
onready var combatNode = get_node("/root/Globals").combatScene



func _ready():
	pass


func _process(delta):
	if(unit != null):
		if(mouseHover):
			if(!unit.infoCard.visible):
				var anchor = combatNode.get_node("HUD/UnitInfoAnchor")
				if(anchor.get_child_count()):
					combatNode.RemoveInfo()
				anchor.add_child(unit.infoCard)
				anchor.rect_global_position = get_global_rect().position + Vector2(75, 0)
				unit.infoCard.SetValues()
				unit.infoCard.visible = true


func Migrate(dest):
	rect_position = get_parent().rect_position - dest.rect_position
	
	get_parent().remove_child(self)
	dest.add_child(self)
	
	$Tween.interpolate_property(self, "rect_position", rect_position, Vector2(0, 0), 0.8, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()


func Appear():
	rect_scale = Vector2(0, 0)
	rect_position = rect_size/2
	$Tween.interpolate_property(self, "rect_scale", rect_scale, Vector2(1, 1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.interpolate_property(self, "rect_position", rect_position, Vector2(0, 0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()


func _on_QueueSlot_mouse_entered():
	mouseHover = true


func _on_QueueSlot_mouse_exited():
	mouseHover = false