extends Node2D

func _ready():
	var sd = Savedata.read()
	if (sd["games"]["mario"]["status"] == 1 and sd["games"]["flappy"]["status"] == 1
	and sd["games"]["candy"]["status"] == 1 and sd["games"]["timber"]["status"] == 1
	and sd["games"]["pacman"]["status"] == 1 and sd["games"]["ferramentas"]["status"] == 1):
		sd["npcs"]["mecanica"]["current_dialog"] = 3 
		sd["npcs"]["mecanica"]["current_speech"] = 0
		sd["endgame"] = true
		Savedata.save(sd)
		

func _on_Door_body_enter( body ):
	Transition.fade_to("res://scenes/Mapas/MapaPlaneta.tscn")


func _on_mecanica_body_enter( body ):
	if body.get_name() == "personagem":
		Global.set_dialog("mecanica",0)
