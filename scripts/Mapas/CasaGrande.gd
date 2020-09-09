extends Node2D
var dentro_da_area_Flappy = false

func _ready():
	var personagem_position = Transition.get_param("before_minigame_position")
	if personagem_position != null:
		get_node("personagem").set_pos(personagem_position)
		Transition.set_param("before_minigame_position", null)
	var sd = Savedata.read()
	if sd["games"]["flappy"]["status"] == 0:
		get_node("BotaoFlappy").set("visibility/visible", true)
	else:
		get_node("BotaoFlappy").set("visibility/visible", false)
		get_node("Ricassa/BotaoDialogo").hide()
func _on_TouchScreenButtonFlappy_pressed():
	if dentro_da_area_Flappy:
		get_node("BotaoFlappy").set("visibility/visible", false)
		Transition.fade_to("res://scenes/Flappy/FlappyGame.tscn", {"before_minigame_position": get_node("personagem").get_pos()})

func _on_AreaBotaoFlappy_body_enter( body ):
	if body.get_name() == "personagem":
		dentro_da_area_Flappy = true

func _on_AreaBotaoFlappy_body_exit( body ):
	dentro_da_area_Flappy = false

func _on_Door_body_enter( body ):
	Transition.fade_to("res://scenes/Mapas/MapaPlaneta.tscn")

func _on_Ricassa_body_enter( body ):
	if body.get_name() == "personagem":
		Global.set_dialog("ricassa",0)


func _on_maridoDaRicassa_body_enter( body ):
	if body.get_name() == "personagem":
		Global.set_dialog("maridoDaRicassa",0)
