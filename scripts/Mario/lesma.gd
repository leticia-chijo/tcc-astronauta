extends KinematicBody2D

var sent = 1
var vivo = true

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	var new_offset = get_parent().get_unit_offset() + delta*sent*0.3
	if sent == 1 and new_offset >= 0.99999:
		sent = -1
		get_parent().set_unit_offset(0.99999)
		get_node("sprite").set_flip_h(false)
	elif sent == -1 and new_offset <= 0:
		sent = 1
		get_parent().set_unit_offset(0)
		get_node("sprite").set_flip_h(true)
	else:
		get_parent().set_unit_offset(new_offset)

func esmagar():
	if not vivo: return
	vivo = false
	get_node("anim").stop()
	get_node("sprite").set_texture(load("res://assets/Mario/Inimigo/slimeDead.png"))
	get_node("sprite").set_offset(Vector2(0,8))
	get_node("shape").queue_free()
	set_fixed_process(false)
	