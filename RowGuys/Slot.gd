extends "res://Party/Slot.gd"


func _ready():
	type = ITYPE.artifact


func _on_Slot_focus_entered():
	release_focus()
	print("Artifact")