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
	combatNode.hoverUnit = unit


func _on_QueueSlot_mouse_exited():
	combatNode.hoverUnit = null