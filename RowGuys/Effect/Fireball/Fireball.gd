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


func _process(delta):
	if(phase == 2):
		if(frame+1 >= frames.get_frame_count(animation)):
			queue_free()
			get_parent().remove_child(self)


func _on_Tween_tween_completed(object, key):
	animation = "Explode"
	$Tween.set_active(false)
	phase = 2
