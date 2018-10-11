extends TextureButton

var mouseHover = false
var bpCost = 0
var unitLink = null


func _ready():
	pass


func _process(delta):
	pass


func Init():
	unitLink.Init()


func HoverInfo():
	var anchor = get_tree().get_current_scene().find_node("Anchor")
	if(anchor != null):
		anchor.add_child(unitLink.infoCard)
	
	mouseHover = true
	unitLink.infoCard.visible = true


func NoHover():
	unitLink.infoCard.get_parent().remove_child(unitLink.infoCard)
	mouseHover = false
	unitLink.infoCard.visible = false


func _on_Adventurer_mouse_entered():
	HoverInfo()


func _on_Adventurer_mouse_exited():
	NoHover()