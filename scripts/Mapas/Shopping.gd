extends Node2D
var dentro_da_area_Timber = false
var dentro_da_area_Candy = false

func _ready():
	var personagem_position = Transition.get_param("before_minigame_position")
	if personagem_position != null:
		get_node("personagem").set_pos(personagem_position)
		Transition.set_param("before_minigame_position", null)
		
	var sd = Savedata.read()
	if sd["games"]["candy"]["status"] != 0:
		get_node("BotaoCandy").set("visibility/visible", false)
		get_node("alfaiate/BotaoDialogo").hide()
	else:
		get_node("BotaoCandy").set("visibility/visible", true)
		
	if sd["games"]["timber"]["status"] != 0:
		get_node("BotaoTimber").set("visibility/visible", false)
		get_node("npcBrinquedos/BotaoDialogo").hide()
	else:
		get_node("BotaoTimber").set("visibility/visible", true)

func _on_TouchScreenTimber_pressed():
	if dentro_da_area_Timber:
		get_node("BotaoTimber").set("visibility/visible", false)
		Transition.fade_to("res://scenes/Brinquedos/game.tscn", {"before_minigame_position": get_node("personagem").get_pos()})

func _on_AreaBotaoTimber_body_enter( body ):
	if body.get_name() == "personagem":
		dentro_da_area_Timber = true

func _on_AreaBotaoTimber_body_exit( body ):
	dentro_da_area_Timber = false

func _on_TouchScreenCandyButton_pressed():
	if dentro_da_area_Candy:
		get_node("BotaoCandy").hide()
		Transition.fade_to("res://scenes/Candy/Level.tscn", {"before_minigame_position": get_node("personagem").get_pos()})

func _on_AreaBotaoCandy_body_enter( body ):
	if body.get_name() == "personagem":
		dentro_da_area_Candy = true

func _on_AreaBotaoCandy_body_exit( body ):
	dentro_da_area_Candy = false

func _on_Door_body_enter( body ):
	Transition.fade_to("res://scenes/Mapas/MapaPlaneta.tscn")

func _on_npcCarro_body_enter( body ):
	if body.get_name() == "personagem":
		Global.set_dialog("vendedorDeCarros",0)

func _on_npcBrinquedos_body_enter( body ):
	if body.get_name() == "personagem":
		Global.set_dialog("vendedorDeBrinquedo",0)

func _on_alfaiate_body_enter( body ):
	if body.get_name() == "personagem":
		Global.set_dialog("vendedor",0)
