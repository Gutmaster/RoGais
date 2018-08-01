extends TextureButton


func _ready():
	pass


func _on_Play_pressed():
	get_node("/root/Globals").ChangeScene(get_node("/root/Globals").overworldScene)
