extends Node

func _on_play_pressed():
	print("mudar de tela")
	HorizontalTransition.fade_to("res://scenes/Mario/game.tscn")
