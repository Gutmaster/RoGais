extends CanvasLayer

onready var eventMenu = $CenterContainer

signal partyChoice

func _ready():
	pass


func close_event():
	if(get_tree().get_current_scene() == get_node("/root/Globals").travelScene):
		$"../../Player".state = $"../../Player".STATES.STOPPED
	eventMenu.visible = false


func _on_CenterContainer_visibility_changed():
	$CenterContainer.rect_global_position = get_viewport().size/2 - $CenterContainer.rect_size