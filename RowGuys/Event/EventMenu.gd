extends CanvasLayer


onready var eventMenu = $Container

onready var party = get_node("/root/Globals").party

signal partyChoice


func _ready():
	$Container.visible = false


func close_event():
	if(get_tree().get_current_scene() == get_node("/root/Globals").travelScene):
		$"../../Player".state = $"../../Player".STATES.STOPPED
	eventMenu.visible = false
	Globals.eventScene = null


func _on_Container_visibility_changed():
	$Container.rect_global_position = get_viewport().size/2 - $Container.rect_size
