extends Node2D
var dentro_da_area = false
var dentro_da_area_end = false
onready var textBox = get_node("Dialog")

func _ready():
	var sd = Savedata.read()
	var tileset_foguete = get_node("tilesWildernessDesX")
	if sd["endgame"] == true:
		#Muda os tiles 
		tileset_foguete.set_cell(-11, 22, -1)
		tileset_foguete.set_cell(-11, 21, -1)
		tileset_foguete.set_cell(-10, 22, -1)
		tileset_foguete.set_cell(-10, 21, -1)
		tileset_foguete.set_cell(-10, 20, -1)
		tileset_foguete.set_cell(-9, 21, -1)
		#Faz foguete aparecer
		get_node("foguete").set("visibility/visible", true)
		
	var personagem_position = Transition.get_param("personagem_position")
	if personagem_position != null:
		get_node("personagem").set_pos(personagem_position)
		
	var sd = Savedata.read()
	if sd["games"]["ferramentas"]["status"] == 0:
		get_node("BotaoFerramentas").set("visibility/visible", true)
	else:
		get_node("BotaoFerramentas").set("visibility/visible", false)
		get_node("ajudante/BotaoDialogo").hide()
	
	print(sd["startPlanet"])
	if sd["startPlanet"] == true: 
		get_node("personagem/CanvasLayer/Controlers/Pause").hide()
	else:
		get_node("mecanicaNoInicio").hide()
		
	
	
func _on_TouchScreenButton_pressed():
	if dentro_da_area:
		get_node("BotaoFerramentas").set("visibility/visible", false)
		Transition.fade_to("res://scenes/Ferramentas/game.tscn", {"personagem_position": get_node("personagem").get_pos() + Vector2(0,30)})

func _on_AreaBotao_body_enter( body ):
	if body.get_name() == "personagem":
		dentro_da_area = true
		
func _on_AreaBotao_body_exit( body ):
	dentro_da_area = false

func _on_EndTouchScreeButton_pressed():
	if dentro_da_area_end:
		Transition.fade_to("res://scenes/gameend/Game.tscn")
func _on_AreaBotaoEnd_body_enter( body ):
	if body.get_name() == "personagem":
		dentro_da_area_end = true
func _on_AreaBotaoEnd_body_exit( body ):
	if body.get_name() == "personagem":
		dentro_da_area_end = false


func _on_mecanicaNoInicio_body_enter( body ):
	if body.get_name() == "personagem":
		Global.set_dialog("mecanica",0)
		var sd = Savedata.read()
		sd["startPlanet"] = false
		Savedata.save(sd)
			
		
func _on_mecanicaNoInicio_body_exit( body ):
	get_node("mecanicaNoInicio").hide()
	get_node("personagem/CanvasLayer/Controlers/Pause").show()


func _on_ajudante_body_enter( body ):
	if body.get_name() == "personagem":
		Global.set_dialog("ajudante",0)
