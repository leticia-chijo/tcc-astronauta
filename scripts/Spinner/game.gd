extends Node

var score1 = 0
var score2 = 0
var spinner1ok = false
var spinner2ok = false
var resetando
var time
signal block
signal unblock

func _ready():
	pass

func atualizaScore():
	get_node("Control/Player1/Score").set_text(str(score1))
	get_node("Control/Player2/Score").set_text(str(score2))
	emit_signal("block")
	spinner1ok = false
	spinner2ok = false

func _on_Spinner1_limit():
	score1 += 1
	atualizaScore()
	get_node("Control/Player1/Msg").set_text("Você ganhou!")
	get_node("Control/Player2/Msg").set_text("Você perdeu!")

func _on_Spinner2_limit():
	score2 += 1
	atualizaScore()
	get_node("Control/Player2/Msg").set_text("Você ganhou!")
	get_node("Control/Player1/Msg").set_text("Você perdeu!")

func _on_Spinner1_zero():
	spinner1ok = true
	if (spinner2ok): reset()

func _on_Spinner2_zero():
		spinner2ok = true
		if (spinner1ok): reset()

func reset():
	if (resetando): return
	else: resetando = true
	get_node("Control/Player2/Msg").set_text("")
	get_node("Control/Player1/Msg").set_text("")
	time = 5
	get_node("EntreRound").start()

func _on_EntreRound_timeout():
	time -= 1
	if (time > 1): 
		get_node("Control/Player2/Msg").set_text(str(time-1))
		get_node("Control/Player1/Msg").set_text(str(time-1))
	if (time == 1):
		get_node("Control/Player2/Msg").set_text("GO!")
		get_node("Control/Player1/Msg").set_text("GO!")
		resetando = false
		emit_signal("unblock")
	if (time == 0):
		get_node("Control/Player2/Msg").set_text("")
		get_node("Control/Player1/Msg").set_text("")