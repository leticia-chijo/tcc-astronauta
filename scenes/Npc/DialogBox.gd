extends Node

var text = ["este é o/a npc", "elx mexe de um jeito doido", ""]
onready var textBox = get_node("layer2/box/textBox")

func _ready():
	if Global.npcAtual == "":
		textBox.start("default")
		print("default")
	else:
		var npc = Global.npcAtual
		textBox.start(npc)
 