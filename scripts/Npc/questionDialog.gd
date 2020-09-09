extends Node

var sd_npcs = Savedata.read()["npcs"]
var npc
onready var qtext = get_node("layer2/box/questionText")
onready var atext = get_node("layer2/box/answerText")
onready var a2text = get_node("layer2/box/answerText2")

func _ready():
	if Global.npcAtual == "":
		npc = "default"
	else:
		npc = Global.npcAtual

	var question = sd_npcs[npc]["dialogs"][sd_npcs[npc]["current_dialog"]][sd_npcs[npc]["current_speech"]]
	qtext.set_bbcode(question["pergunta"])
	atext.set_bbcode(question["resp1"])
	a2text.set_bbcode(question["resp2"])


func _on_answerButton_pressed():
	var sd = Savedata.read()
	sd["npcs"][npc]["current_dialog"] = 2 
	sd["npcs"][npc]["current_speech"] = 0
	Savedata.save(sd)
	Transition.clear_above()
	Transition.put_above("res://scenes/Npc/DialogBox.tscn")
	
func _on_answerButton2_pressed():
	var sd = Savedata.read()
	sd["npcs"][npc]["current_dialog"] = 1 
	sd["npcs"][npc]["current_speech"] = 0
	Savedata.save(sd)
	Transition.clear_above()
	Transition.put_above("res://scenes/Npc/DialogBox.tscn")
