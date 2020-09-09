extends KinematicBody2D

onready var rayE = get_node("rayE")
onready var rayD = get_node("rayD")
onready var sprite = get_node("sprite")

var vivo = true
var fim = false
var left
var right
var up

signal morreu
signal fim
signal moeda
signal quaseFim
#-----------------------------------------------------------

const GRAVITY = 1100.0 # Pixels/second

const FLOOR_ANGLE_TOLERANCE = 40
const WALK_FORCE = 600
const WALK_MIN_SPEED = 10
const WALK_MAX_SPEED = 300
const STOP_FORCE = 1300
const JUMP_SPEED = 700
const JUMP_MAX_AIRBORNE_TIME = 0.2

const SLIDE_STOP_VELOCITY = 1.0 # One pixel per second
const SLIDE_STOP_MIN_TRAVEL = 1.0 # One pixel

var velocity = Vector2()
var on_air_time = 100
var jumping = false

var prev_jump_pressed = false


func _fixed_process(delta):
	var force = Vector2(0, GRAVITY)
	
	var walk_left = (Input.is_action_pressed("move_left") or left) and vivo
	var walk_right = (Input.is_action_pressed("move_right") or right or fim) and vivo
	var jump = (Input.is_action_pressed("jump") or up) and vivo
	
	var stop = true
	
	if (walk_left):
		if (velocity.x <= WALK_MIN_SPEED and velocity.x > -WALK_MAX_SPEED):
			force.x -= WALK_FORCE
			stop = false
	elif (walk_right):
		if (velocity.x >= -WALK_MIN_SPEED and velocity.x < WALK_MAX_SPEED):
			force.x += WALK_FORCE
			stop = false
	
	if (stop):
		var vsign = sign(velocity.x)
		var vlen = abs(velocity.x)
		
		vlen -= STOP_FORCE*delta
		if (vlen < 0):
			vlen = 0
		
		velocity.x = vlen*vsign
	
	velocity += force*delta
	
	var motion = velocity*delta
	
	motion = move(motion)
	
	var floor_velocity = Vector2()
	
	if (is_colliding()):
		var n = get_collision_normal()
		
		if (rad2deg(acos(n.dot(Vector2(0, -1)))) < FLOOR_ANGLE_TOLERANCE):
			on_air_time = 0
			floor_velocity = get_collider_velocity()
		
		if (on_air_time == 0 and force.x == 0 and get_travel().length() < SLIDE_STOP_MIN_TRAVEL and abs(velocity.x) < SLIDE_STOP_VELOCITY and get_collider_velocity() == Vector2()):
			
			revert_motion()
			velocity.y = 0.0
		else:
			motion = n.slide(motion)
			velocity = n.slide(velocity)
			move(motion)
	
	if (floor_velocity != Vector2()):
		move(floor_velocity*delta)
	
	if (jumping and velocity.y > 0):
		jumping = false
	
	if (on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not prev_jump_pressed and not jumping):
		velocity.y = -JUMP_SPEED
		jumping = true
	
	on_air_time += delta
	prev_jump_pressed = jump

	var no_chao = (rayE.is_colliding() or rayD.is_colliding())
	
	if walk_right:
		sprite.set_flip_h(false)
	if walk_left:
		sprite.set_flip_h(true)
		
	if (walk_left or walk_right) and no_chao:
		if !get_node("anim").is_playing():
			get_node("anim").play("walk")
		
	elif (walk_left or walk_right):
		get_node("anim").stop()
		sprite.set_frame(7)
		
	else:
		get_node("anim").stop()
		sprite.set_frame(7)
		
	if get_pos().y > 1100:
		morrer()

func _ready():
	set_fixed_process(true)

func _on_pes_body_enter( body ):
	if not vivo: return
	pular()
	body.esmagar()

func pular():
	velocity.y = -JUMP_SPEED
	jumping = true

func _on_corpo_body_enter( body ):
	if not vivo: return
	morrer()

func morrer():
	if not vivo: return
	vivo = false
	velocity.y = -500
	get_node("shape").set_trigger(true)
	emit_signal("morreu")

func _on_cabeca_body_enter( body ):
	if not vivo: return
	if body.has_method("destruir"):
		body.destruir()

func _on_touchLeft_pressed():
	left = true

func _on_touchLeft_released():
	left = false

func _on_touchRight_pressed():
	right = true
	
func _on_touchRight_released():
	right = false

func _on_touchUp_pressed():
	up = true

func _on_touchUp_released():
	up = false
	
func reviver():
	velocity = Vector2(0,0)
	get_node("shape").set_trigger(false)
	get_node("camera").make_current()
	vivo = true
	fim = false

func _on_fim_body_enter( body ):
	fim = true
	emit_signal("fim")

func moeda():
	emit_signal("moeda")

func _on_game_time_timeout():
	morrer()

func _on_areaQuaseFim_body_enter( body ):
	emit_signal("quaseFim")
