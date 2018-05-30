extends "res://Effect/EffectCatalogue.gd"


func _ready():
	pass


func Init(var user, var target):
	position = user.position
	start = Vector2(0,0) + position
	end = Vector2(0,0) + position + target.position
	animation = "Travel"
	$Tween.interpolate_property(self, "position", position, end - start, 0.8, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	phase = 1


func _on_Tween_tween_completed(object, key):
	animation = "Explode"
	$Tween.set_active(false)
	phase = 2


func _on_Firecracker_animation_finished():
	if(animation == "Explode"):
		queue_free()
		get_parent().remove_child(self)
