extends CenterContainer


enum ITYPE{
artifact,
trinket,
item}


onready var type = ITYPE.item
onready var item = null

func _ready():
	pass


func _on_Slot_focus_entered():
	release_focus()
	print("Item")