extends RigidBody2D
var play = false
onready var cena = get_tree().get_current_scene()

func _ready():
	set_mode(MODE_STATIC)
	set_gravity_scale(0)
	set_process_input(true)
	
func _input(event):
	if event.is_action_pressed("touch"):
		if play == false and cena.estado == cena.INICIAL:
			play = true
			cena.get_node("Canos/Gerador/Timer").start()
			cena.get_node("Background/BackAnim").play("BackAnim")
			set_mode(MODE_CHARACTER)
			set_gravity_scale(18)
			cena.estado = cena.JOGANDO
		on_touch()

func set_play(value):
	play = value

func on_touch():
	if (cena.estado != cena.GANHOU):
		apply_impulse(Vector2(0,0), Vector2(0,-1000))
	
func win():
	var sd = Savedata.read()
	sd["games"]["flappy"]["status"] = 1
	Savedata.save(sd)
	
	get_node("FelpudoAnim").stop()
	set_mode(MODE_STATIC)
	set_gravity_scale(0)