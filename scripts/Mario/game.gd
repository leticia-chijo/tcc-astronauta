extends Node

onready var perc = get_node("personagem")
onready var camera = get_node("dead_camera")
var moedas = 0
var vidas = 3
var ganhou = false

func _ready():
	set_process(true)
	start()
	
func start():
	get_node("canvasLayer/Panel").show()
	get_node("canvasLayer/end/lose").set("visibility/visible", false)
	get_node("canvasLayer/end/lose").set_scale(Vector2(0,0))
	get_node("canvasLayer/end/won").set("visibility/visible", false)
	get_node("canvasLayer/end/won").set_scale(Vector2(0,0))
func _process(delta):
	var g_time = get_node("game_time")
	if g_time != null:
		get_node("canvasLayer/Panel/time").set_text(str(int(g_time.get_time_left())))

func change_camera():
	camera.set_global_pos(perc.get_node("camera").get_camera_pos())
	camera.make_current()

func _on_personagem_morreu():
	change_camera()
	get_node("spawnTime").set_wait_time(2)
	get_node("spawnTime").start()
	vidas -= 1
	if vidas == 2:
		get_node("canvasLayer/Panel/heart1").set_texture(load("res://assets/Mario/hud_heartEmpty.png"))
	elif vidas == 1:
		get_node("canvasLayer/Panel/heart2").set_texture(load("res://assets/Mario/hud_heartEmpty.png"))
	elif vidas == 0:
		get_node("canvasLayer/Panel/heart3").set_texture(load("res://assets/Mario/hud_heartEmpty.png"))

func _on_spawnTime_timeout():
	if vidas > 0:
		reviver()
	else:
		lose()

func reviver():
	if ganhou == false:
		perc.set_pos(get_node("spawnPoint").get_pos())
		perc.reviver()
		get_node("game_time").set_wait_time(30)
		get_node("game_time").start()

func _on_personagem_fim():
	won()
	
func _on_personagem_moeda():
	moedas +=1
	get_node("canvasLayer/Panel/moedas").set_text(str(moedas))

func _on_backtomap_pressed():
	Transition.fade_to("res://scenes/Mapas/Mercado.tscn")

func won():
	change_camera()
	self.ganhou = true
	get_node("game_time").set_autostart(false)
	get_node("game_time").stop()
	get_node("spawnTime").stop()
	get_node("canvasLayer/Panel").hide()
	get_node("canvasLayer/controles").hide()
	
	var sd = Savedata.read()
	sd["games"]["mario"]["status"] = 1
	Savedata.save(sd)
	
	var anim = get_node("canvasLayer/end/AnimationPlayer")
	anim.play("won")
	yield(anim, "finished")

func lose():
	get_node("game_time").stop()
	get_node("spawnTime").stop()
	get_node("canvasLayer/Panel").hide()
	var anim = get_node("canvasLayer/end/AnimationPlayer")
	anim.play("lose")
	yield(anim, "finished")

func _on_playagain_button_pressed():
	Transition.fade_to("res://scenes/Mario/game.tscn")

func _on_backtomap_button_pressed():
	Transition.fade_to("res://scenes/Mapas/Mercado.tscn")
	
func _on_personagem_quaseFim():
	if moedas == 15:
		get_node("quaseFim").queue_free()
	else:
		var anim = get_node("canvasLayer/end/AnimationPlayer")
		anim.play("faltaFruta")
		
func _on_backToFruit_pressed():
	get_node("canvasLayer/end/faltaFruta").set("visibility/visible", false)
	
