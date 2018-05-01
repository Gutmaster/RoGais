extends Sprite

var currentRoom = null
var nextRoom = null


func _ready():
	currentRoom = get_parent().find_node("Room1")


func Move(var room):
	nextRoom = room
	$Tween.interpolate_property(self, "position", position, room.position, 0.8, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	get_parent().moveFlag = true


func _on_Tween_tween_completed(object, key):
	get_parent().moveFlag = false
	nextRoom.MoveParty()