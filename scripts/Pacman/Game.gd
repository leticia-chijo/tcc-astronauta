extends Node


func _on_backtoCasaVelha_pressed():
	Transition.fade_to("res://scenes/Mapas/CasaVelha.tscn")


func _on_playagain_button_pressed():
	Transition.fade_to("res://scenes/Pacman/Game.tscn")

func _on_backtomap_button_pressed():
	var sd = Savedata.read()
	sd["games"]["pacman"]["status"] = 1
	Savedata.save(sd)
	Transition.fade_to("res://scenes/Mapas/CasaVelha.tscn")
