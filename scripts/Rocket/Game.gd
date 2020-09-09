
onready var rocket = get_node("Rocket")
onready var camera = get_node("Camera")
onready var meteor = get_node("Meteors")
onready var labels = get_node("Labels")

var meteor1 = preload("res://scenes//Rocket/meteor1.tscn")
var meteor2 = preload("res://scenes//Rocket/meteor2.tscn")
var meteor3 = preload("res://scenes//Rocket/meteor3.tscn")
var meteor4 = preload("res://scenes//Rocket/meteor4.tscn")
var meteor5 = preload("res://scenes//Rocket/meteor5.tscn")

var score = 0
var life = 3
var battery = 100
var newpoint = 0
var died = false

var dir
var desired_pos

func _ready():
	var sd = Savedata.read()
	sd["games"]["rocket"]["status"] = 0
	set_process(true)
	labels.get_node("Lifes/Lifes").set_text(str(life))
	labels.get_node("Battery/ProgressBar").set_value(battery)
	labels.get_node("NewPoint/ProgressBar").set_value(newpoint)
	get_node("gamestart/AnimationPlayer").play("start")
	
	
func _process(delta):
	dir = Vector2(0,0)
	if Input.is_action_pressed("left"):
		dir = Vector2(-1, 0)
	if Input.is_action_pressed("right"):
		dir = Vector2(1, 0)
	
	desired_pos = rocket.get_position() + dir*rocket.get_speed()
	if(
		desired_pos.x > -280 + 400 and
		desired_pos.x < 280 + 400
	):
		rocket.set_position(desired_pos)

func _on_Generator_timeout():

	if not died:
		for i in range(0,rand_range(1,2)):
			var type = int(rand_range(0,5))
			var obj
			if type == 0:
				obj = meteor1.instance()
			elif type == 1:
				obj = meteor2.instance()
			elif type == 2:
				obj = meteor3.instance()
			elif type == 3:
				obj = meteor4.instance()
			elif type == 4:
				obj = meteor5.instance()
	
			obj.born(Vector2(rand_range(0,640), 0))
			meteor.add_child(obj)


func _on_Rocket_die():
	if not died:
		life -= 1
		labels.get_node("Lifes/Lifes").set_text(str(life))
		battery -= 10
		labels.get_node("Battery/ProgressBar").set_value(battery)
		if battery <= 0: die()
		if life == 0: die()


func _on_ScoreTimer_timeout():
	if not died:
		if newpoint == 100:
			newpoint = 0
			labels.get_node("NewPoint/ProgressBar").set_value(newpoint)
			score += 10
			labels.get_node("Score/Score").set_text(str(score))
		else:
			newpoint += 10
			labels.get_node("NewPoint/ProgressBar").set_value(newpoint)
		
		


func _on_LowerBattery_timeout():
	battery -= 5
	labels.get_node("Battery/ProgressBar").set_value(battery)
	if battery <= 0: die()

func die():
	died = true
	var sd = Savedata.read()
	sd["games"]["rocket"]["status"] = 1
	Savedata.save(sd)
	var anim = labels.get_node("GameOver").get_node("AnimationPlayer")
	anim.play("Nova Animação")
	yield(anim, "finished")
	Transition.fade_to("res://scenes/Mapas/MapaPlaneta.tscn", {"personagem_position": Vector2(-580, 1390)})

func _on_AnimationPlayer_finished():
	get_node("Generator").start()
	get_node("ScoreTimer").start()
	