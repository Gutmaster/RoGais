extends CanvasLayer


func _ready():
	$Container.visible = true


func _on_Confirm_pressed():
	get_parent().queue_free()
	get_node("/root/Dungeon").eventActive = false