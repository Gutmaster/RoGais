extends "res://Effect/EffectCatalogue.gd"


var user
var target


func _ready():
	pass


func Init(var usr, var targ):
	target = targ
	user = usr
	position = user.position
	start = Vector2(0,0) + position
	end = Vector2(0,0) + position + target.position
	$Length.add_point(Vector2(0,0))
	$Length.add_point(user.position - position)
	$Tween.interpolate_property(self, "position", position, end - start, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	phase = 1


func _process(delta):
	if(phase > 0):
		$Length.set_point_position(1, user.position - position)
	if(phase == 2):
		position = target.position
		if(target.shifting == false):
			start = Vector2(0,0) + position
			end = Vector2(0,0) + position + user.position
			$Tween.interpolate_property(self, "position", position, end - start, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
			$Tween.start()
			phase = 3


func _on_Tween_tween_completed(object, key):
	$Tween.set_active(false)
	if(phase == 3):
		user.print_tree()
		user.cAction.projectile = null
		user.cAction.Cleanup()
		queue_free()
		get_parent().remove_child(self)
	else:
		phase = 2
