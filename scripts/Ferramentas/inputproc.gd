extends Node2D
onready var limit = get_node("limit")
onready var interrequest = get_node("interrequest")

var pressed = false
var drag = false
var currentpos = Vector2(0, 0)
var oldpos = Vector2(0, 0)

var died = false
func _ready():
	set_process_input(true)
	set_fixed_process(true)
	
func _fixed_process(delta):
	update()
	if drag and currentpos != oldpos and oldpos != Vector2(0, 0) and !died:
		var space_state = get_world_2d().get_direct_space_state()
		var result = space_state.intersect_ray(oldpos, currentpos)
		if not result.empty():
			result.collider.cut()
			
	
func _input(event):
	event = make_input_local(event)
	if event.type == InputEvent.SCREEN_TOUCH:
		if event.pressed:
			pressed(event.pos)
		else:
			released()
	elif event.type == InputEvent.SCREEN_DRAG:
		drag(event.pos)

func pressed(pos):
	pressed = true
	oldpos = pos
	limit.start()
	interrequest.start()
	
func released():
	pressed = false
	drag = false
	limit.stop()
	interrequest.stop()
	currentpos = Vector2(0, 0)
	oldpos = Vector2(0, 0)
	
func drag(pos):
	currentpos = pos
	drag = true

func _on_interrequest_timeout():
	oldpos = currentpos

func _on_limit_timeout():
	released()
	
func _draw():
	if drag and currentpos != oldpos and oldpos != Vector2(0, 0) and !died:
		draw_line(currentpos, oldpos, Color(1, 0.2, 0.3), 5)
