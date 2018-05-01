extends Area2D


func _ready():
	pass


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		on_click()


func on_click():
    print("Click")


func _on_Area2D_mouse_entered():
	get_parent().unit.mouseHover = true


func _on_Area2D_mouse_exited():
	get_parent().unit.mouseHover = false