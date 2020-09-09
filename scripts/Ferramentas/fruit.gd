extends RigidBody2D
onready var shape = get_node("shape")
onready var sprite0 = get_node("sprite0")
onready var body1 = get_node("body1")
onready var body2 = get_node("body2")
onready var sprite1 = body1.get_node("sprite1")
onready var sprite2 = body2.get_node("sprite2")

var cortada
signal score
signal life

func _ready():
	randomize()
	set_process(true)
	
func _process(delta):
	if get_pos().y > 1280:
		queue_free()
	if body1.get_pos().y > 1280 and body2.get_pos().y > 1280:
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
	cortada = true
	emit_signal("score")
	set_mode(MODE_KINEMATIC)
	sprite0.queue_free()
	shape.queue_free()
	body1.set_mode(MODE_RIGID)
	body2.set_mode(MODE_RIGID)
	
	body1.apply_impulse(Vector2(0, 0), Vector2(-100, 0).rotated(get_rot()))
	body2.apply_impulse(Vector2(0, 0), Vector2(100, 0).rotated(get_rot()))
	body1.set_angular_velocity(get_angular_velocity())
	body2.set_angular_velocity(get_angular_velocity())
		