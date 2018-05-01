extends TextureButton



func _ready():
	pass


func _on_Victory_pressed():
	get_node("/root/Combat").EndBattle()