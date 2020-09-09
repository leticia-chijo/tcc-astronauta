extends KinematicBody2D

onready var sprite = get_node("sprite")
onready var anim = get_node("anim")

const SPEED = 250.0

var vel = Vector2(0,0)
var facingDir = "down"

func _ready():
	sprite.set_frame(0)
	set_process_input(true)
	set_fixed_process(true)

	
func _input(event):
	#controls
	var WALK_RIGHT = Input.is_action_pressed("ui_right")
	var WALK_LEFT = Input.is_action_pressed("ui_left")
	var WALK_UP = Input.is_action_pressed("ui_up")
	var WALK_DOWN = Input.is_action_pressed("ui_down")
	
	#movement direction
	vel.x =  WALK_RIGHT - WALK_LEFT
	vel.x *= SPEED
	vel.y =  WALK_DOWN - WALK_UP
	vel.y *= SPEED

func _fixed_process(delta):
	move(vel*delta)
	
	#walking animation
	if vel.x < 0 :
		if !anim.is_playing():
			anim.play("walk_down")
			facingDir = "down"
		vel.y = 0
	elif vel.x > 0:
		if !anim.is_playing(): 
			anim.play("walk_up")
			facingDir = "up"
		vel.y = 0
	elif  vel.y < 0:
		if !anim.is_playing():
			anim.play("walk_left")
			facingDir = "left"
		vel.x = 0
	elif  vel.y > 0:
		if !anim.is_playing():
			anim.play("walk_right")
			facingDir = "right"
		vel.x = 0
	
	#idle position sprite
	else:
		anim.stop_all()
		if facingDir == "right":
			sprite.set_frame(7)
		elif facingDir == "left":
			sprite.set_frame(4)
		elif facingDir == "up":
			sprite.set_frame(10)
		else:
			sprite.set_frame(1)