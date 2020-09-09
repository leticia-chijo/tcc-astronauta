var posdisc
var dir
var destdisc
var destcont
var speed
var dead
var eaten = []
var pacman_center = Vector2(16,16)
var sd
var remaining_food = 0
signal pac
var max_remaining_food = 0
onready var tiles = get_parent().get_node("TileMap")
onready var food = get_parent().get_node("Food")
onready var end = get_parent().get_parent().get_node("end")
onready var controls = get_parent().get_parent().get_node("Controls")

func _ready():
	sd = Savedata.read()["games"]["pacman"]["metadata"]
	for posdisc in sd["eaten"]:
		food.set_cell(posdisc.x, posdisc.y, -1)
	get_node("../../Hud").set_score(sd["score"])
	
	end.get_node("won").set("visibility/visible", false)
	end.get_node("won").set_scale(Vector2(0, 0))
	end.get_node("lose").set("visibility/visible", false)
	end.get_node("lose").set_scale(Vector2(0, 0))
	controls.set("visibility/visible", true)
	
	count_food()
	spawn()
	set_process(true)

func count_food():
	for i in range(0, 18):
		for j in range(0, 20):
			if food.get_cell(i, j) != -1:
				remaining_food += 1

func spawn():
	# posicao discreta de inicio
	posdisc = Vector2(9, 15)
	# considera centro do pacman
	set_pos(posdisc * 32 + pacman_center)
	
	dir = Vector2(0, 0)
	destdisc = posdisc
	destcont = get_pos()
	
	speed = 150
	dead = false
	
	set_scale(Vector2(1, 1))
	get_node("AnimatedSprite/Sprite").set_scale(Vector2(1, 1))

func lose():
	controls.set("visibility/visible", false)
	end.get_node("AnimationPlayer").play("lose")

	sd = Savedata.read()
	sd["games"]["pacman"]["metadata"]["score"] = get_parent().get_parent().get_node("Hud").score
	sd["games"]["pacman"]["metadata"]["eaten"] = eaten
	Savedata.save(sd)
	
	
func won():
	controls.set("visibility/visible", false)
	sd = Savedata.read()
	sd["games"]["pacman"]["status"] = 1
	sd["games"]["pacman"]["score"] = get_parent().get_parent().get_node("Hud").score
	Savedata.save(sd)
	
	end.get_node("AnimationPlayer").play("won")
	
func _process(delta):
	if remaining_food <= max_remaining_food:
		emit_signal("pac", "won")
		won()
		set_process(false)
	if dead: return
	var delcont = destcont - get_pos()
	if delcont != Vector2(0, 0):
		#Chegou no lugar
		if delcont.length() < 2:
			set_pos(destdisc*32 + pacman_center)
			posdisc = destdisc
			
			# Comer
			if food.get_cell(posdisc.x, posdisc.y) == 0:
				eaten.append(posdisc)
				food.set_cell(posdisc.x, posdisc.y, -1)
				get_node("../../Hud").add_score(10)
				remaining_food -= 1
				
		else:
			set_pos(get_pos() + delta * speed * delcont.normalized())
			
	else:
		
		if dir != Vector2(0,0):
			var destdiscaux = posdisc + dir
			if destdiscaux == Vector2(19,9):
				# Teletransporte pro outro lado do mapa
				destdiscaux = Vector2(0, 9)
				set_pos(Vector2(-1, 9)*32 + pacman_center)
			elif destdiscaux == Vector2(-1, 9):
				destdiscaux = Vector2(18, 9)
				set_pos(Vector2(19, 9)*32 + pacman_center)
			# Não pode entrar na parede nem onde os fantasmas nascem
			if (
				tiles.get_cell(destdiscaux.x, destdiscaux.y) != 2
				and destdiscaux != Vector2(9, 8)
				):
				destdisc = destdiscaux
				destcont = get_pos()+ 32 * dir
				emit_signal("pac", "move")
			
	dir = Vector2(0, 0)
	if Input.is_action_pressed("left"):
		dir = Vector2(-1, 0)
		get_node("AnimatedSprite/AnimationPlayer").play("left")
	elif Input.is_action_pressed("right"):
		dir = Vector2(1, 0)
		get_node("AnimatedSprite/AnimationPlayer").play("right")

	elif Input.is_action_pressed("up"):
		dir = Vector2(0, -1)
		get_node("AnimatedSprite/AnimationPlayer").play("up")

	elif Input.is_action_pressed("down"):
		dir = Vector2(0, 1)
		get_node("AnimatedSprite/AnimationPlayer").play("down")

func _on_Area_area_enter( area ):
	if remaining_food <= max_remaining_food: return
	if dead: return
	# Verifica estado do fantasma
	if area.get_parent().state == area.get_parent().NORMAL:
		# mata pacman
		dead = true
		get_node("AnimatedSprite/AnimationPlayer").play("DieAnim")
		emit_signal("pac", "die")
		yield(get_node("AnimatedSprite/AnimationPlayer"), "finished")
		lose()

