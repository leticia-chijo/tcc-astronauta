extends Node2D
var spritered = preload("res://assets/Personagens/$Lanto138.png")
var spriteblue = preload("res://assets/Personagens/$Lanto129.png")
var spriteorange = preload("res://assets/Personagens/$Lanto200.png")
var spritepink = preload("res://assets/Personagens/$Lanto127.png")
var sprites = {
	"GhostRed":spritered,
	"GhostBlue": spriteblue,
	"GhostOrange": spriteorange,
	"GhostPink": spritepink
}
onready var tilemap = get_parent().get_node("TileMap")

onready var pacman = get_parent().get_node("Personagem")


export var iniposdisc = Vector2()
export var color = ""
export var points = 0

var posdisc
var destdisc
var destcont

var speed
var state
enum{NORMAL, BLUE, DEAD}

var path
var bluedir


var ghost_center = Vector2(16, 16)

func _ready():
	get_node("AnimatedSprite/Sprite").set_texture(sprites[get_name()])
	spawn()
	
	set_process(true)
	
func spawn():
	posdisc = iniposdisc
	destdisc = posdisc
	get_node("AnimatedSprite/AnimationPlayer").play("down")
	set_pos(posdisc*32 + ghost_center)
	destcont = get_pos()
	speed =  70
	path = []
	bluedir = Vector2(0, -1)
	state = NORMAL
	
	
func _process(delta):
	if (
		state == DEAD
		or get_node("../../Hud").score < points
	): return 
	
	var delcont = destcont - get_pos()
	if delcont != Vector2(0, 0):
		if delcont.length() < 2:
			set_pos(destdisc*32 + ghost_center)
			posdisc = destdisc
			
			calc_move()
		else:
			if delcont.normalized().x == 1:
				get_node("AnimatedSprite/AnimationPlayer").play("right")
			elif delcont.normalized().x == -1:
				get_node("AnimatedSprite/AnimationPlayer").play("left")
			elif delcont.normalized().y == -1:
				get_node("AnimatedSprite/AnimationPlayer").play("up")
			elif delcont.normalized().y == 1:
				get_node("AnimatedSprite/AnimationPlayer").play("down")
				
			set_pos(get_pos() + delta*speed*delcont.normalized())
	else:
		go_to_next()
func calc_move():
	if state == NORMAL:
		calc_move_normal()
	elif state == BLUE:
		calc_move_blue()

func go_to_next():
	if path == null or path == []:
		return
	
	destdisc = path[0]
	destcont = destdisc*32 + ghost_center
	path.remove(0)

func calc_move_blue():
	path = []
	var aux = bluedir
	
	while(true):
		var calcdest = destdisc + aux
		if (
		aux + bluedir != Vector2(0,0)
		and tilemap.get_cell(calcdest.x, calcdest.y) != 2
		):
			bluedir = aux
			path.append(calcdest)
			return
		else:
			randomize()
			var rand =  int(rand_range(0, 4))
			if rand == 0:
				aux = Vector2(0, 1)
			elif rand == 1:
				aux = Vector2(0,- 1)
			elif rand == 2:
				aux = Vector2(1, 0)
			elif rand == 3:
				aux = Vector2(-1, 0)
			
			
func respawn():
	var anim = get_node("Anim")
	speed = 0
	anim.play("Respawn")
	yield(anim, "finished")
	get_node("SpecTimer").stop()
	get_node("AnimatedSprite/Sprite").set_modulate(Color(1, 1, 1, 1))
	spawn()
	
	
func _on_Personagem_pac(mode):
	if mode == "die":
		speed = 0
		get_node("SpecTimer").stop()
		get_node("Anim").play("Hide")
		#respawn()
	elif mode == "won":
		speed = 0
		get_node("AnimatedSprite/Sprite").set("visibility/visible", false)
		
	elif mode == "spec":
		if get_node("../../Hud").score < points: return
		if state == BLUE:
			get_node("SpecTimer").stop()
			#get_node("Anim").stop()
			get_node("AnimatedSprite/Sprite").set_modulate(Color(1, 1, 1, 1))
		state = BLUE
		speed = 70
		get_node("SpecTimer").start()
		get_node("AnimatedSprite/Sprite").set_modulate(Color(1, 0, 0, 1))
	elif mode == "move":
		if destcont - get_pos() == Vector2(0, 0):
			calc_move()
	elif mode == "reset":
		get_node("Anim").play("Respawn")
		yield(get_node("Anim"), "finished")
		get_node("AnimatedSprite/Sprite").set_modulate(Color(1, 1, 1, 1))
		

func _on_SpecTimer_timeout():
	get_node("Anim").play("GoToNormal")
	yield(get_node("Anim"), "finished")
	
	state = NORMAL
	speed = 70
	set_color()

func set_color():
	get_node("AnimatedSprite/Sprite").set_modulate(Color(1, 1, 1, 1))


func _on_SpawnTimer_timeout():
	state = NORMAL
