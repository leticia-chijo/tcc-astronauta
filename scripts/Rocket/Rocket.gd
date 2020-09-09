extends Node2D
var posdisc
var dir
var destdisc
var destcont
var speed
var dead = false
var last_meteore_name = ""

signal die

func _ready():
	set_process(true)
	posdisc = Vector2(400, 1100)
	
	set_pos(posdisc)
	set_z(5)
	dir = Vector2(0, 0)
	destdisc = posdisc
	destcont = get_pos()
	
	speed = 5
func set_position(position):
	set_pos(position)
	
func get_speed():
	return 10

func get_position():
	return get_pos()


func _on_Area2D_body_enter( body ):
	if body.get_parent().get_name() == "Meteors":
		if last_meteore_name != body.get_name():
			emit_signal("die")
			last_meteore_name = body.get_name()
