extends Area2D


func _ready():
	pass


func _on_Area2D_mouse_entered():
	get_parent().unit.mouseHover = true


func _on_Area2D_mouse_exited():
	get_parent().unit.mouseHover = false