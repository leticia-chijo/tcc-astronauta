extends Node2D
var dentro_da_area = false

func _ready():
	var personagem_position = Transition.get_param("before_minigame_position")
	if personagem_position != null:
		get_node("personagem").set_pos(personagem_position)
		Transition.set_param("before_minigame_position", null)
	var sd = Savedata.read()
	if sd["games"]["mario"]["status"] == 0:
		get_node("BotaoMario").set("visibility/visible", true)
	else:
		get_node("BotaoMario").set("visibility/visible", false)
		get_node("mercadora/BotaoDialogo").hide()
		
		

func _on_TouchScreenButton_pressed():
	if dentro_da_area:
		get_node("BotaoMario").set("visibility/visible", false)
		Transition.fade_to(
			"res://scenes/Mario/game.tscn",
			{"before_minigame_position": get_node("personagem").get_pos()}
		)

func _on_AreaBotao_body_enter( body ):
	if body.get_name() == "personagem":
		dentro_da_area = true
		
func _on_AreaBotao_body_exit( body ):
	dentro_da_area = false
	
func _on_Door_body_enter( body ):
	Transition.fade_to("res://scenes/Mapas/MapaPlaneta.tscn")


func _on_mercador_body_enter( body ):
	if body.get_name() == "personagem":
		Global.set_dialog("mercadora",0)
