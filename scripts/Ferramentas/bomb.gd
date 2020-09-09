extends RigidBody2D
onready var shape = get_node("shape")
onready var sprite = get_node("sprite")
onready var animation = get_node("animation")

signal error
var cortada = false


func _ready():
	set_process(true)
	randomize()
func _process(delta):
	if get_pos().y > 1280:
		queue_free()
	
func born(pos0):
	set_pos(pos0)
	var v0 = Vector2(0, rand_range(-1500, -1200))
	if pos0.x < 400:
		v0 = v0.rotated(deg2rad(rand_range(-9, 0)))
	else:
		v0 = v0.rotated(deg2rad(rand_range(0, 9)))
	set_linear_velocity(v0)
	set_angular_velocity(rand_range(-7, 7))

func cut():
	if cortada:
		return
	else:
		cortada = true
		emit_signal("error")
		set_mode(MODE_KINEMATIC)
		animation.play("explode")