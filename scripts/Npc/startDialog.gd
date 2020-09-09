extends Node

onready var textBox = get_node("layer2/box/label")

func _ready():
	textBox.set_bbcode("Você deseja falar com a "+Global.npcAtual+"?")

func _on_buttonYes_pressed():
	Transition.clear_above()
	Transition.put_above("res://scenes/Npc/DialogBox.tscn")

func _on_buttonNo_pressed():
	Transition.clear_above()
