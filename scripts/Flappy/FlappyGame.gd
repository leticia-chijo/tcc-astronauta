extends Node2D
var max_canos = 10
onready var felpudo = get_node("Felpudo")
onready var lable = get_node("Node2D/Control/Label")
var pontos = 0
var estado = INICIAL
const INICIAL = 0
const JOGANDO = 1
const PERDENDO = 2
const GANHOU = 3
var last_cano = false
var string = "{pontos}/{max_canos}"


func _ready():
	get_node("Canos/Gerador").connect("last", self, "_on_last_cano")
	lable.set_text(string.format({"pontos": pontos, "max_canos": max_canos}))
	
func kill():
	felpudo.apply_impulse(Vector2(0,0), Vector2(-1000,0))
	get_node("Background/BackAnim").stop()
	estado = PERDENDO
	get_node("Felpudo").set_play(false)
	get_node("end/end_anim").play("lose")


func pontuar():
	pontos += 1
	lable.set_text(string.format({"pontos": pontos, "max_canos": max_canos}))
	
	if last_cano and pontos == max_canos:
		var sd = Savedata.read()
		sd["games"]["flappy"]["status"] = 1
		sd["games"]["flappy"]["score"] = pontos
		Savedata.save(sd)
		
		get_node("end/end_anim").play("won")
		get_node("Background/BackAnim").stop()
		estado = GANHOU
		felpudo.win()
		
func _on_backtomap_button_pressed():
	Transition.fade_to("res://scenes/Mapas/CasaGrande.tscn")


func _on_playagain_button_pressed():
	print(estado)
	get_tree().reload_current_scene()


func _on_TouchScreenButton_pressed():
	Transition.fade_to("res://scenes/Mapas/CasaGrande.tscn")
	
func _on_last_cano():
	get_node("Canos").hide()
	last_cano = true
	
	
