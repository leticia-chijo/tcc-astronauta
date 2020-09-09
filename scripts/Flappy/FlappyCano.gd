extends Node2D

var cena
export var vel = -400
var pontuado = false
func _ready():
	cena = get_tree().get_current_scene()
	set_process(true)
	
func _process(delta):
	if (cena.estado == cena.JOGANDO):
		if delta != 0:
			set_pos(get_pos() + Vector2(vel*delta,0))
	
	if (get_pos().x < -100):
		queue_free()

func _on_Area2D_body_enter( body ):
	if (body.get_name() == "Felpudo"):
		cena.kill()

func _on_Ponto_body_enter( body ):
	if !pontuado:
		pontuado = true
		cena.pontuar()

