extends RigidBody2D

#onready var shape = get_node("Shape")
onready var sprite = get_node("Sprite")

signal score
signal die

func _ready():
	randomize()
	set_process(true)

func _process(delta):
	if (get_pos().y > 1280):
		queue_free()


func born(inipos):
	set_pos(inipos)
	var inivel = Vector2(rand_range(-400, 400),rand_range(800, 1000))
	if (inipos.x < 640):
		inivel = inivel.rotated(deg2rad(rand_range(0,-10)))
	else:
		inivel = inivel.rotated(deg2rad(rand_range(0,10)))
	set_linear_velocity(inivel)
	set_angular_velocity(rand_range(-5,5))

func die():
	print("die")

