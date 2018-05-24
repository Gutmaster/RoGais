extends "res://Overworld/Scripts/Objects/OverworldObject.gd"


var packedDungeon = load("res://Dungeon/Dungeon.tscn")


func _ready():
	pass


func LoadDungeon():
	var dungeon = packedDungeon.instance()
	get_node("/root/Globals").dungeonScene = dungeon
	get_node("/root/Globals").ChangeScene(get_node("/root/Globals").dungeonScene)
	#dungeon.Init()