extends Area2D

var color
var special = false
var sel = false
var x
var y
var destx
var desty
var posx
var posy

signal selected(obj,b)

func _ready():
	randomize()
	color = int(rand_range(0,5))
	get_node("Sprite").set_animation(get_type(color))
	set_process(true)

func _process(delta):
	if destx == null or desty == null or (destx == x and desty == y): return
	
	var delx = posx - get_pos().x
	var dely = posy - get_pos().y
	var speed = Vector2(0,0)
	
	if abs(delx) > 20:
		speed.x = 300*(destx - x)
	else:
		set_pos(Vector2(posx, get_pos().y))
		x = destx
	
	if abs(dely) > 20:
		speed.y = 300*(desty - y)
	else:
		set_pos(Vector2(get_pos().x, posy))
		y = desty
	
	set_pos(get_pos() + speed * delta)

func get_type(n):
	if n == 0:
		return "tankTop"
	elif n == 1:
		return "longSleeve"
	elif n == 2:
		return "tshirt"
	elif n == 3:
		return "short"
	elif n == 4:
		return "pants"
	elif n== 5:
		return "slippers"

func _on_Candy_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed:
		if sel:
			desel()
			emit_signal("selected", self, false)
		else:
			sel()
			emit_signal("selected", self, true)

func desel():
	sel = false
	get_node("Sel").hide()

func sel():
	sel = true
	get_node("Sel").show()

func set_data(x,y):
	self.x = x
	self.y = y
	set_pos(Vector2(45+x*120+120/2, 290+y*120+120/2))

func move_to(gx,gy):
	destx = gx
	desty = gy
	posx = get_pos().x + (gx-x)*120
	posy = get_pos().y + (gy-y)*120
