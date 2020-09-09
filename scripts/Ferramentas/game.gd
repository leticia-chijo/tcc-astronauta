extends Node2D
onready var fruits = get_node("fruits")

var pot = preload("res://scenes/Ferramentas/pot.tscn")
var rolling = preload("res://scenes/Ferramentas/rolling.tscn")
var spray = preload("res://scenes/Ferramentas/spray.tscn")
var duster = preload("res://scenes/Ferramentas/duster.tscn")
var iron = preload("res://scenes/Ferramentas/iron.tscn")
var mirror = preload("res://scenes/Ferramentas/mirror.tscn")
var mixer = preload("res://scenes/Ferramentas/mixer.tscn")

var gear = preload("res://scenes/Ferramentas/gear.tscn")
var wrench = preload("res://scenes/Ferramentas/wrench.tscn")
var nut = preload("res://scenes/Ferramentas/nut.tscn")
var caliper = preload("res://scenes/Ferramentas/caliper.tscn")
var hammer = preload("res://scenes/Ferramentas/hammer.tscn")

const fruit_max = 50
const error_max = 3

var fruit_count
var error_count
var score
var gameover_reason = ""

func _ready():
	initialize()
	pass
	
func initialize():
	get_node("inputproc").died = false
	get_node("control/error1").hide()
	get_node("control/error2").hide()
	get_node("control/error3").hide()
	
	get_node("end/won").set_scale(Vector2(0, 0))
	get_node("end/won").set("visibility/visible", false)
	get_node("end/lose").set_scale(Vector2(0, 0))
	get_node("end/lose").set("visibility/visible", false)
	
	fruit_count = 0
	error_count = 0
	score = 0
	gameover_reason = ""
	
	get_node("control/progressbar").set_value(100*score/fruit_max)
	get_node("Generator").start()
	
func _on_Generator_timeout():
	if error_count >= 3: return
	if fruit_count >= fruit_max:
		call_end()
		
	else:
		for i in range(0, rand_range(1, 4)):
			var type = int(rand_range(0, 9))
			var obj
			if type == 0:
				obj = duster.instance()
				fruit_count += 1
			elif type == 1:
				obj = iron.instance()
				fruit_count += 1
			elif type == 2:
				obj = mirror.instance()
				fruit_count += 1
			elif type == 3:
				obj = mixer.instance()
				fruit_count += 1
			elif type == 4:
				obj = pot.instance()
				fruit_count += 1
			elif type == 5:
				obj = spray.instance()
				fruit_count += 1
			elif type == 6:
				obj = rolling.instance()
				fruit_count += 1
			else:
				var bomb_type = int(rand_range(0, 5))
				if bomb_type == 0:
					obj = wrench.instance()
				elif bomb_type == 1:
					obj = nut.instance()
				elif bomb_type == 2:
					obj = gear.instance()
				elif bomb_type == 3:
					obj = caliper.instance()
				else:
					obj = hammer.instance()
				obj.connect("error", self, "count_error")
				
			obj.born(Vector2(rand_range(370, 430), 1280))
			if (type <= 6):
				obj.connect("score", self, "inc_score")
			fruits.add_child(obj)
		
func call_end():
	get_node("Generator").stop()
	if score < 0.95*fruit_max:
		gameover_reason = "Você não selecionou bem as ferramentas"
		get_node("end/lose/reason_label").set_text(gameover_reason)
		get_node("end/end_anim").play("lose")
	else:
		var sd = Savedata.read()
		sd["games"]["ferramentas"]["status"] = 1
		sd["games"]["ferramentas"]["score"] = score
		Savedata.save(sd)
		get_node("end/end_anim").play("won")


func count_error():
	error_count += 1
	if error_count == 3:
		get_node("control/error1").show()
		get_node("inputproc").died = true
		
		gameover_reason = "Você eliminou muitas ferramentas"
		get_node("end/lose/reason_label").set_text(gameover_reason)
		get_node("end/end_anim").play("lose")
		
	elif error_count == 2:
		get_node("control/error2").show()
	elif error_count == 1:
		get_node("control/error3").show()
	
func inc_score():
	if error_count >= 3: return
	else:
		score += 1
		get_node("control/progressbar").set_value(100*score/fruit_max)
		

func _on_gotomap_pressed():
	Transition.fade_to("res://scenes/Mapas/MapaPlaneta.tscn")

func _on_playagain_pressed():
	get_tree().reload_current_scene()

func _on_backtoplanet_pressed():
	Transition.fade_to("res://scenes/Mapas/MapaPlaneta.tscn")
