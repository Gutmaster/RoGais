extends TextureButton


func _ready():
	pass


func _on_Play_pressed():
	LoadParty()
	get_node("/root/Globals").ChangeScene(get_node("/root/Globals").overworldScene)


func LoadParty():
	var party = get_node("/root/Globals").party
	party.AddUnit(load("res://Unit/Senor Salvadia/Senor Salvadia.tscn"))
	party.AddUnit(load("res://Unit/Billy Beastman/Billy Beastman.tscn"))
	party.AddUnit(load("res://Unit/Dank Druid/Dank Druid.tscn"))
	party.AddUnit(load("res://Unit/Tiki Fireballer/Tiki Fireballer.tscn"))